//
//  BNCSQLiteDataBaseStatement.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteDataBaseStatement.h"
#import "BNCSQLiteDataBase.h"

@interface BNCSQLiteDataBaseStatement()

@property (nonatomic, unsafe_unretained, readwrite) sqlite3_stmt *statement;
@property (nonatomic, unsafe_unretained, readwrite) sqlite3 *database;

@end

@implementation BNCSQLiteDataBaseStatement

- (instancetype)initWithSQLString:(NSString *)sqlString database:(BNCSQLiteDataBase *)database error:(NSError *__autoreleasing *)error {
    self = [super init];
    if (self) {
        
        _database = database.database;
        
        // Prepare Action
        int result = sqlite3_prepare_v2(_database, [sqlString UTF8String], (int)sqlString.length, &_statement, NULL);
        if (result != SQLITE_OK) {
            self.statement = nil;
            NSString *sqlErrorMessage = [NSString stringWithUTF8String:sqlite3_errmsg(_database)];
            
            NSError *generatedError = [NSError errorWithDomain:kBNCSQLiteErrorDomain code:result userInfo:@{NSLocalizedDescriptionKey:sqlErrorMessage}];
            
            if (error != nil) {
                *error = generatedError;
            }
            
            [self finalizeStatement];
            return nil;
        }
    }
    
    return self;
}

- (void)dealloc {
    [self finalizeStatement];
}

- (void)finalizeStatement {
    if (!_statement) {
        return;
    }
    
    sqlite3_finalize(_statement);
    _statement = nil;
}

- (NSInteger)stepStatement {
    if (!_statement) {
        return SQLITE_MISUSE;
    }
    
    return sqlite3_step(_statement);
}

- (BOOL)resetStatementWithError:(NSError *__autoreleasing *)error;{
    NSInteger result = sqlite3_reset(_statement);
    
    if (result != SQLITE_OK) {
        NSString *sqlErrorMessage = [NSString stringWithUTF8String:sqlite3_errmsg(_database)];
        
        NSError *generatedError = [NSError errorWithDomain:kBNCSQLiteErrorDomain code:result userInfo:@{NSLocalizedDescriptionKey:sqlErrorMessage}];
        
        if (error != nil) {
            *error = generatedError;
        }
        
        return NO;
    }
    
    return YES;
}

- (NSInteger)columnCount {
    if (!_statement) {
        return 0;
    }
    
    return sqlite3_column_count(_statement);
}

@end
