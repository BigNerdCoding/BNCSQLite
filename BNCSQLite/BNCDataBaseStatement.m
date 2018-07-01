//
//  BNCDataBaseStatement.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCDataBaseStatement.h"
#import "BNCDataBase.h"

@interface BNCDataBaseStatement()

@property (nonatomic, unsafe_unretained) sqlite3_stmt *statement;
@property (nonatomic, unsafe_unretained) sqlite3 *database;

@end

@implementation BNCDataBaseStatement

- (instancetype)initWithSQLString:(NSString *)sqlString database:(BNCDataBase *)database error:(NSError *__autoreleasing *)error {
    self = [super init];
    if (self) {
        
        _database = database.database;
        
        // Prepare 
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

- (void)finalizeStatement {
    if (!_statement) {
        return;
    }
    
    sqlite3_finalize(_statement);
    _statement = nil;
}

- (NSInteger)stepStatament {
    if (!_statement) {
        return SQLITE_MISUSE;
    }
    
    return sqlite3_step(_statement);
}

- (int)queryBindParameterIndex:(NSString *)columnName {
    const char *cColumnName = [columnName UTF8String];
    return sqlite3_bind_parameter_index(_statement, cColumnName);
}

- (int)columnCount {
    if (!_statement) {
        return 0;
    }
    
    return sqlite3_column_count(_statement);
}

#pragma mark - Internal Bind Process For Each Type

- (void)bindNull:(NSString *)columnName {
    sqlite3_bind_null(_statement,[self queryBindParameterIndex:columnName]);
}

- (void)bindColumn:(NSString *)columnName withIntValue:(int64_t)iValue {
    sqlite3_bind_int64(_statement, [self queryBindParameterIndex:columnName], iValue);
}

- (void)bindColumn:(NSString *)columnName withDoubleValue:(double)dValue {
    sqlite3_bind_double(_statement, [self queryBindParameterIndex:columnName], dValue);
}

- (void)bindColumn:(NSString *)columnName withTextValue:(NSString *)tValue {
    sqlite3_bind_text(_statement, [self queryBindParameterIndex:columnName], [tValue UTF8String], -1, SQLITE_TRANSIENT);
}

- (void)bindColumn:(NSString *)columnName withBinaryValue:(NSData *)bValue {
     sqlite3_bind_blob(_statement, [self queryBindParameterIndex:columnName], bValue.bytes, (int)bValue.length, SQLITE_TRANSIENT);
}

#pragma mark - Internal Fetch Process From Result
- (int64_t)fetchIntResult:(int)iValuePosition {
    return sqlite3_column_int64(_statement, iValuePosition);
}

- (double)fetchDoubleResult:(int)dValuePosition {
    return sqlite3_column_double(_statement, dValuePosition);
}

- (NSString *)fetchTextResult:(int)tValuePosition {
    const char *textValue = (const char*)sqlite3_column_text(_statement, tValuePosition);
    
    return [[NSString alloc] initWithCString:textValue encoding:NSUTF8StringEncoding];
}

- (NSData *)fetchBinaryResult:(int)bValuePosition {
    NSData *binaryResult = nil;
    
    int bytes = sqlite3_column_bytes(_statement, bValuePosition);
    if (bytes > 0) {
        const void *blob = sqlite3_column_blob(_statement, bValuePosition);
        
        if (blob != NULL) {
            binaryResult = [NSData dataWithBytes:blob length:bytes];
        }
    }
    
    return binaryResult;
}

@end
