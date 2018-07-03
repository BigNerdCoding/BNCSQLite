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
#import "BNCSQLiteDatabaseConfig.h"

NSString * const kBNCSQLiteErrorDomain = @"kBNCSQLiteErrorDomain";
NSString * const kBNCSQLiteInitVersion = @"kBNCSQLiteInitVersion";

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
        int result = sqlite3_open_v2(path, &(_database),
                                     SQLITE_OPEN_CREATE |
                                     SQLITE_OPEN_READWRITE |
                                     SQLITE_OPEN_NOMUTEX |
                                     SQLITE_OPEN_SHAREDCACHE,
                                     NULL);
        
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
        if (isFileExistsBefore && ![[self currentVersion] isEqualToString:config.latestSchemaVersion] && !config.migrationAction) {
            // Do Migration
            config.migrationAction(self);
        }
    }
    
    return self;
}

- (void)dealloc {
    [self closeDatabase];
}

- (void)closeDatabase {
    if (@available(iOS 8.2, *)) {
        sqlite3_close_v2(_database);
    } else {
        sqlite3_close(_database);
    }
    
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

- (NSString *)currentVersion {
    NSString *sql = @"pragma user_version";
    
    __block NSString *version = @"";
    [self executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowID) {
        version = [statement takeTextColumn:1];
    } error:nil];
    
    if (version && ![version isEqualToString:@""] ) {
        return version;
    }
    
    version = kBNCSQLiteInitVersion;
    
    [self updateSchemaVersion:version];
    
    return version;
}

- (void)updateSchemaVersion:(NSString *)schemaVersion {
    NSString *userVserion = [NSString stringWithFormat:@"pragma user_version = %@", schemaVersion];
    
    [self executeSQL:userVserion bind:nil rowHandle:nil error:nil];
}

- (BOOL)executeSQLWithTransaction:(void (^)(void))transaction lockType:(BNCSQLiteTransactionLockType)lockType {
    NSString *sql = @"";
    switch (lockType) {
        case BNCSQLiteTransactionLockTypeDeferred:
            sql = @"BEGIN DEFERRED TRANSACTION;";
            break;
        case BNCSQLiteTransactionLockTypeImmediate:
            sql = @"BEGIN IMMEDIATE TRANSACTION;";
            break;
        case BNCSQLiteTransactionLockTypeExclusive:
            sql = @"BEGIN EXCLUSIVE TRANSACTION;";
            break;
    }
    
    BOOL isSuccess = YES;
    
    @try {
        [self executeSQL:sql bind:nil rowHandle:nil error:nil];
        transaction();
        [self executeSQL:@"COMMIT" bind:nil rowHandle:nil error:nil];
    } @catch (NSException *exception) {
        [self executeSQL:@"ROLLBACK" bind:nil rowHandle:nil error:nil];
        isSuccess = NO;
    }
    
    return isSuccess;
}

- (BOOL)executeSQL:(NSString *)sqlString bind:(BindBlock)bind rowHandle:(RowHandleBlock)rowHandle error:(NSError *__autoreleasing *)error {
    BNCSQLiteDatabaseStatement *sqlStatement = [[BNCSQLiteDatabaseStatement alloc] initWithSQLString:sqlString database:self error:error];
    
    if (!sqlStatement || error) {
        [sqlStatement finalizeStatement];
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
    
    NSInteger rowNum = 1;
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