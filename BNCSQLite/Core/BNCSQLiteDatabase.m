//
//  BNCSQLiteDatabase.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/6/29.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteDatabase.h"
#import "BNCSQLiteDatabaseStatement.h"
#import "BNCSQLiteDatabaseStatement+Take.h"
#import "BNCSQLiteDatabaseStatement+Bind.h"
#import "BNCSQLiteDatabaseConfig.h"

@interface BNCSQLiteDatabase()

@property (nonatomic, unsafe_unretained, readwrite) sqlite3 *database;
@property (nonatomic, copy) NSString *databaseFilePath;

@end

@implementation BNCSQLiteDatabase

- (instancetype)initWithConfig:(BNCSQLiteDatabaseConfig *)config error:(NSError *__autoreleasing *)error {
    self = [super init];
    if (self) {
        NSString *filePath = config.filePath;
        
        NSAssert(filePath != nil, @"database filePath must not be nil");
        
        _databaseFilePath = filePath;
        
        NSString *checkDirPath = [_databaseFilePath stringByDeletingLastPathComponent];
        NSFileManager *defaultFileManager = [NSFileManager defaultManager];
        
        if (![defaultFileManager fileExistsAtPath:checkDirPath]) {
            [defaultFileManager createDirectoryAtPath:checkDirPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        BOOL isFileExistsBefore = [defaultFileManager fileExistsAtPath:filePath];
        
        const char *path = [_databaseFilePath UTF8String];
        
        int flag = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE | SQLITE_OPEN_NOMUTEX | SQLITE_OPEN_SHAREDCACHE;
        
        if ([config isReadonly]) {
            flag = SQLITE_OPEN_READONLY | SQLITE_OPEN_NOMUTEX | SQLITE_OPEN_SHAREDCACHE;
        }
        
        int result = sqlite3_open_v2(path, &(_database), flag, NULL);
        
        if (result != SQLITE_OK && error) {
            NSString *sqliteErrorString = [NSString stringWithCString:sqlite3_errmsg(self.database) encoding:NSUTF8StringEncoding];
            
            *error = [NSError errorWithDomain:kBNCSQLiteErrorDomain code:result userInfo:@{NSLocalizedDescriptionKey:sqliteErrorString}];
            
            [self closeDatabase];
            return nil;
        }
        
        // Setting latestVsersion
        if (!isFileExistsBefore) {
            [self updateSchemaVersion:config.latestSchemaVersion];
        }
        
        // Need Migration
        if (isFileExistsBefore && [self currentVersion] < config.latestSchemaVersion && config.migrationAction) {
            // Do Migration
            config.migrationAction(self);
        }
        
        // Whethere activate wal mode
        if (config.isReadonly || !config.isWALModeOn) {
            return self;
        }
        
        NSString *sql = @"PRAGMA journal_mode = WAL";
        __block NSString *journalMode = @"";
        [self executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowID) {
            journalMode = [statement takeTextColumnAt:0];
        } error:error];
        
        if (![journalMode isEqualToString:@"wal"]) {
            NSString *sqliteErrorString = [NSString stringWithFormat:@"could not activate WAL Mode at path:%@", config.filePath];
            
            *error = [NSError errorWithDomain:kBNCSQLiteErrorDomain code:[*error code] userInfo:@{NSLocalizedDescriptionKey:sqliteErrorString}];
            
            return nil;
        }
        
        sql = @"PRAGMA synchronous = NORMAL";
        [self executeSQL:sql bind:nil rowHandle:nil error:nil];
    }
    
    return self;
}

- (void)dealloc {
    [self closeDatabase];
}

- (void)closeDatabase {
    
    if (!_database) {
        return;
    }
    
    int  rc;
    BOOL retry;
    BOOL triedFinalizingOpenStatements = NO;
    
    do {
        retry   = NO;
        if (@available(iOS 8.2, *)) {
            rc = sqlite3_close_v2(_database);
        } else {
            rc = sqlite3_close(_database);
        }

        if (SQLITE_BUSY == rc || SQLITE_LOCKED == rc) {
            if (!triedFinalizingOpenStatements) {
                triedFinalizingOpenStatements = YES;
                sqlite3_stmt *pStmt;
                while ((pStmt = sqlite3_next_stmt(_database, nil)) != nil) {
                    NSLog(@"Closing leaked statement");
                    sqlite3_finalize(pStmt);
                    retry = YES;
                }
            }
        } else if (SQLITE_OK != rc) {
            NSLog(@"error closing!: %d", rc);
        }
    } while (retry);
    
    _database = NULL;
    _databaseFilePath = nil;
}

- (UInt64)latestInsertRowID {
    return sqlite3_last_insert_rowid(_database);
}

- (UInt64)changes {
    return sqlite3_changes(_database);
}

- (UInt64)totalChanges {
    return sqlite3_total_changes(_database);
}

- (UInt64)currentVersion {
    NSString *sql = @"pragma user_version ;";
    
    __block UInt64 version = kBNCSQLiteInitVersion;
    [self executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowID) {
        version = [statement takeIntColumnAt:0];
    } error:nil];
    
    return version;
}

- (void)updateSchemaVersion:(NSInteger)schemaVersion {
    NSString *userVserion = [NSString stringWithFormat:@"pragma user_version = %ld ",(long)schemaVersion] ;
    
    [self executeSQL:userVserion bind:nil rowHandle:nil error:nil];
}

- (BOOL)executeSQLWithTransaction:(BOOL (^)(void))transaction lockType:(BNCSQLiteTransactionLockType)lockType {
    NSString *sql = @"";
    switch (lockType) {
        case BNCSQLiteTransactionLockTypeDeferred:
            sql = @"BEGIN DEFERRED TRANSACTION ;";
            break;
        case BNCSQLiteTransactionLockTypeImmediate:
            sql = @"BEGIN IMMEDIATE TRANSACTION ;";
            break;
        case BNCSQLiteTransactionLockTypeExclusive:
            sql = @"BEGIN EXCLUSIVE TRANSACTION ;";
            break;
    }
    
    BOOL isSuccess = YES;
    
    @try {
        [self executeSQL:sql bind:nil rowHandle:nil error:nil];
        
        if (transaction) {
            isSuccess = transaction();
        }
        
        if (isSuccess) {
            [self executeSQL:@"COMMIT ;" bind:nil rowHandle:nil error:nil];
        } else {
            [self executeSQL:@"ROLLBACK ;" bind:nil rowHandle:nil error:nil];
        }
        
    } @catch (NSException *exception) {
        [self executeSQL:@"ROLLBACK ;" bind:nil rowHandle:nil error:nil];
        isSuccess = NO;
    }
    
    return isSuccess;
}

- (BOOL)executeSQL:(NSString *)sqlString bind:(BindBlock)bind rowHandle:(RowHandleBlock)rowHandle error:(NSError *__autoreleasing *)error {
    BNCSQLiteDatabaseStatement *sqlStatement = [[BNCSQLiteDatabaseStatement alloc] initWithSQLString:sqlString database:self error:error];
    
    if (!sqlStatement) {
        return NO;
    }
    
    // Do Bind
    if (bind) {
        bind(sqlStatement);
    }
    
    // Execute
    NSInteger result = [sqlStatement stepStatement];
    if (result != SQLITE_DONE && result!= SQLITE_ROW) {
        NSString *sqliteErrorString = [NSString stringWithCString:sqlite3_errmsg(self.database) encoding:NSUTF8StringEncoding];
        
        NSError *generatedError = [NSError errorWithDomain:kBNCSQLiteErrorDomain code:result userInfo:@{NSLocalizedDescriptionKey:sqliteErrorString}];
        
        if (error != nil) {
            *error = generatedError;
        }
        
        [sqlStatement finalizeStatement];
        return NO;
    }
    
    UInt64 rowNum = 1;
    while (result == SQLITE_ROW) {
        
        if (rowHandle) {
            rowHandle(sqlStatement, rowNum);
        }
        
        rowNum += 1;
        result = [sqlStatement stepStatement];
    }
    
    [sqlStatement finalizeStatement];
    return YES;
}

@end
