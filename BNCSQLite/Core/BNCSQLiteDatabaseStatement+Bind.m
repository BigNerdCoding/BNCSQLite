//
//  BNCSQLiteDatabaseStatement+Bind.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteDatabaseStatement+Bind.h"
#import "BNCSQLiteDatabase.h"
#import <UIKit/UIKit.h>

@implementation BNCSQLiteDatabaseStatement (Bind)

#pragma mark - Bind With Position
- (void)bindNullAt:(int)position {
    sqlite3_bind_null(self.statement,position);
}

- (void)bindInteger:(int64_t)iValue atPosition:(int)position {
    sqlite3_bind_int64(self.statement, position, iValue);
}

- (void)bindDoubleValue:(double)dValue atPosition:(int)position {
    sqlite3_bind_double(self.statement, position, dValue);
}

- (void)bindTextValue:(NSString *)tValue atPosition:(int)position {
    sqlite3_bind_text(self.statement, position, [tValue UTF8String], -1, SQLITE_TRANSIENT);
}

- (void)bindBinaryValue:(NSData *)bValue atPosition:(int)position {
    sqlite3_bind_blob(self.statement,position , bValue.bytes, (int)bValue.length, SQLITE_TRANSIENT);
}

#pragma mark - Bind With ColumnName

- (void)bindNullColumn:(NSString *)columnName {
    [self bindNullAt:[self queryBindParameterIndex:columnName]];
}

- (void)bindColumn:(NSString *)columnName withIntValue:(int64_t)iValue {
    [self bindInteger:iValue atPosition:[self queryBindParameterIndex:columnName]];
}

- (void)bindColumn:(NSString *)columnName withDoubleValue:(double)dValue {
    [self bindDoubleValue:dValue atPosition:[self queryBindParameterIndex:columnName]];
}

- (void)bindColumn:(NSString *)columnName withTextValue:(NSString *)tValue {
    [self bindTextValue:tValue atPosition:[self queryBindParameterIndex:columnName]];
}

- (void)bindColumn:(NSString *)columnName withBinaryValue:(NSData *)bValue {
    [self bindBinaryValue:bValue atPosition:[self queryBindParameterIndex:columnName]];
}

#pragma mark - Bind With id Type
- (void)bindColumn:(NSString *)columnName withValue:(id)bindValue {
    if (columnName == nil) {
        return;
    }
    
    if (bindValue == nil) {
        bindValue = [NSNull null];
    }
    
    NSString *valueType = nil;
    if ([bindValue isKindOfClass:[NSNumber class]]) {
        NSNumber *value = (NSNumber *)bindValue;
        if (strcmp(value.objCType, @encode(int)) == 0
            || strcmp(value.objCType, @encode(long)) == 0
            || strcmp(value.objCType, @encode(long long)) == 0
            || strcmp(value.objCType, @encode(NSInteger)) == 0
            || strcmp(value.objCType, @encode(NSUInteger)) == 0
            || strcmp(value.objCType, @encode(short)) == 0) {
            
            valueType = @"INTEGER";
            
        } else if (strcmp(value.objCType, @encode(float)) == 0
                   || strcmp(value.objCType, @encode(double)) == 0
                   || strcmp(value.objCType, @encode(CGFloat)) == 0) {
            
            valueType = @"REAL";
            
        } else if (strcmp(value.objCType, @encode(BOOL)) == 0
                   || strcmp(value.objCType, @encode(Boolean)) == 0
                   || strcmp(value.objCType, @encode(boolean_t)) == 0
                   || strcmp(value.objCType, @encode(char)) == 0) {
            
            valueType = @"BOOLEAN";
        }
    }
    
    if ([bindValue isKindOfClass:[NSString class]]) {
        valueType = @"TEXT";
    }
    if ([bindValue isKindOfClass:[NSNull class]]) {
        valueType = @"NULL";
    }
    if ([bindValue isKindOfClass:[NSData class]]) {
        valueType = @"BLOB";
    }
    
    if ([valueType isEqualToString:@"INTEGER"]) {
        [self bindColumn:columnName withIntValue:[bindValue longLongValue]];
        return;
    }
    
    if ([valueType isEqualToString:@"TEXT"]) {
        [self bindColumn:columnName withTextValue:bindValue];
        return;
    }
    
    if ([valueType isEqualToString:@"REAL"]) {
        [self bindColumn:columnName withDoubleValue:[bindValue doubleValue]];
        return;
    }
    
    if ([valueType isEqualToString:@"BLOB"]) {
        [self bindColumn:columnName withBinaryValue:bindValue];
        return;
    }
    
    if ([valueType isEqualToString:@"BOOLEAN"]) {
        [self bindColumn:columnName withIntValue:[bindValue longLongValue]];
        return;
    }
    
    if ([valueType isEqualToString:@"NULL"]) {
        [self bindNullColumn:columnName];
        return;
    }
}
@end
