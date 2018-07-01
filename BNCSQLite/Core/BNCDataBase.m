//
//  BNCDataBase.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/6/29.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCDataBase.h"
#import "BNCDataBaseStatement.h"

NSString * const kBNCSQLiteErrorDomain = @"kBNCSQLiteErrorDomain";

@interface BNCDataBase()

@property (nonatomic, unsafe_unretained, readwrite) sqlite3 *database;
@property (nonatomic, copy) NSString *databaseFilePath;

@end

@implementation BNCDataBase

- (instancetype)initWithPath:(NSString *)filePath error:(NSError *__autoreleasing *)error {
    self = [super init];
    if (self) {
        NSAssert(filePath != nil, @"database filePath must not be nil");
        
        _databaseFilePath = filePath;
        
        NSString *checkDirPath = [_databaseFilePath stringByDeletingLastPathComponent];
        NSFileManager *defaultFileManager = [NSFileManager defaultManager];
        
        if (![defaultFileManager fileExistsAtPath:checkDirPath]) {
            [defaultFileManager createDirectoryAtPath:checkDirPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
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

- (void)executeSQLWithTransaction:(void(^)(void))transaction {
    @try {
        [self executeSQL:@"BEGIN TRANSACTION" bind:nil rowHandle:nil error:nil];
        transaction();
        [self executeSQL:@"COMMIT" bind:nil rowHandle:nil error:nil];
    } @catch (NSException *exception) {
        [self executeSQL:@"ROLLBACK" bind:nil rowHandle:nil error:nil];
    }
}

- (BOOL)executeSQL:(NSString *)sqlString bind:(BindBlock)bind rowHandle:(RowHandleBlock)rowHandle error:(NSError *__autoreleasing *)error {
    BNCDataBaseStatement *sqlStatement = [[BNCDataBaseStatement alloc] initWithSQLString:sqlString database:self error:error];
    
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
