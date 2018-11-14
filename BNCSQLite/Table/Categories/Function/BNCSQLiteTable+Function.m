//
//  BNCSQLiteTable+Function.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/11/14.
//  Copyright © 2018 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable+Function.h"
#import "BNCSQLiteDatabaseStatement+Bind.h"
#import "BNCSQLiteDatabaseStatement+Take.h"

@implementation BNCSQLiteTable (Function)

#pragma mark - count function

- (UInt64)countTotalRecord {
    return [self countWithCondition:@""];
}

- (UInt64)countWithCondition:(NSString *)whereCondition {
    NSString *whereCaluse = @"";
    
    if (whereCondition && ![whereCondition isEqualToString:@""]) {
        whereCaluse = [NSString stringWithFormat:@" WHERE %@ ",whereCondition];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT COUNT(*) AS count FROM %@ %@;", self.tableName, whereCaluse];
    
    __block UInt64 nCount = 0;
    
    [self.dbConnect executeSQL:sqlString bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        nCount = [statement takeIntColumnAt:0];
    } error:nil];
    
    return nCount;
}

- (UInt64)countWithCondition:(NSString *)whereCondition
                      params:(NSDictionary *)whereConditionParams {
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT COUNT(*) AS count FROM %@ WHERE %@ ;", self.tableName, whereCondition];
    
    __block UInt64 nCount = 0;
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [whereConditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        nCount = [statement takeIntColumnAt:0];
    } error:nil];
    
    return nCount;
}

#pragma mark - max function
- (UInt64)maxIntValueOfColumn:(NSString *)column {
    return [self maxIntValueOfColumn:column where:@""];
}

- (UInt64)maxIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition {
    NSString *whereCaluse = @"";
    
    if (whereCondition && ![whereCondition isEqualToString:@""]) {
        whereCaluse = [NSString stringWithFormat:@" WHERE %@ ",whereCondition];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT MAX(%@) AS max FROM %@ %@ ;", column, self.tableName, whereCaluse];
    
    __block UInt64 nMax = 0;
    
    [self.dbConnect executeSQL:sqlString bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        nMax = [statement takeIntColumnAt:0];
    } error:nil];
    
    return nMax;
}

- (UInt64)maxIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition
                       params:(NSDictionary *)whereConditionParams {
    NSString *sqlString = [NSString stringWithFormat:@"SELECT MAX(%@) AS max FROM %@ WHERE %@ ;", column, self.tableName, whereCondition];
    
    __block UInt64 nMax = 0;
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [whereConditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        nMax = [statement takeIntColumnAt:0];
    } error:nil];
    
    return nMax;
}

- (double)maxDoubleValueOfColumn:(NSString *)column {
    return [self maxDoubleValueOfColumn:column where:@""];
}

- (double)maxDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition {
    NSString *whereCaluse = @"";
    
    if (whereCondition && ![whereCondition isEqualToString:@""]) {
        whereCaluse = [NSString stringWithFormat:@" WHERE %@ ",whereCondition];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT MAX(%@) AS max FROM %@ %@ ;", column, self.tableName, whereCaluse];
    
    __block double dMax = 0.0;
    
    [self.dbConnect executeSQL:sqlString bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        dMax = [statement takeDoubleColumnAt:0];
    } error:nil];
    
    return dMax;
}

- (double)maxDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition
                          params:(NSDictionary *)whereConditionParams {
    NSString *sqlString = [NSString stringWithFormat:@"SELECT MAX(%@) AS max FROM %@ WHERE %@ ;", column, self.tableName, whereCondition];
    
    __block double dMax = 0.0;
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [whereConditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        dMax = [statement takeDoubleColumnAt:0];
    } error:nil];
    
    return dMax;
}

#pragma mark - min function
- (UInt64)minIntValueOfColumn:(NSString *)column {
    return [self minIntValueOfColumn:column where:@""];
}

- (UInt64)minIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition {
    NSString *whereCaluse = @"";
    
    if (whereCondition && ![whereCondition isEqualToString:@""]) {
        whereCaluse = [NSString stringWithFormat:@" WHERE %@ ",whereCondition];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT MIN(%@) AS max FROM %@ %@ ;", column, self.tableName, whereCaluse];
    
    __block UInt64 nMin = 0;
    
    [self.dbConnect executeSQL:sqlString bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        nMin = [statement takeIntColumnAt:0];
    } error:nil];
    
    return nMin;
}

- (UInt64)minIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition
                       params:(NSDictionary *)whereConditionParams {
    NSString *sqlString = [NSString stringWithFormat:@"SELECT MIN(%@) AS min FROM %@ WHERE %@ ;", column, self.tableName, whereCondition];
    
    __block UInt64 nMin = 0.0;
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [whereConditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        nMin = [statement takeIntColumnAt:0];
    } error:nil];
    
    return nMin;
}

- (double)minDoubleValueOfColumn:(NSString *)column {
    return [self minIntValueOfColumn:column where:@""];
}

- (double)minDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition {
    NSString *whereCaluse = @"";
    
    if (whereCondition && ![whereCondition isEqualToString:@""]) {
        whereCaluse = [NSString stringWithFormat:@" WHERE %@ ",whereCondition];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT MIN(%@) AS min FROM %@ %@ ;", column, self.tableName, whereCaluse];
    
    __block double dMin = 0.0;
    
    [self.dbConnect executeSQL:sqlString bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        dMin = [statement takeDoubleColumnAt:0];
    } error:nil];
    
    return dMin;
}

- (double)minDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition
                          params:(NSDictionary *)whereConditionParams {
    NSString *sqlString = [NSString stringWithFormat:@"SELECT MIN(%@) AS min FROM %@ WHERE %@ ;", column, self.tableName, whereCondition];
    
    __block double dMin = 0.0;
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [whereConditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        dMin = [statement takeDoubleColumnAt:0];
    } error:nil];
    
    return dMin;
}

#pragma mark - sum function
- (UInt64)sumIntValueOfColumn:(NSString *)column {
    return [self sumIntValueOfColumn:column where:@""];
}

- (UInt64)sumIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition {
    NSString *whereCaluse = @"";
    
    if (whereCondition && ![whereCondition isEqualToString:@""]) {
        whereCaluse = [NSString stringWithFormat:@" WHERE %@ ",whereCondition];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT TOTAL(%@) AS sum FROM %@ %@ ;", column, self.tableName, whereCaluse];
    
    __block UInt64 nSum = 0;
    
    [self.dbConnect executeSQL:sqlString bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        nSum = [statement takeIntColumnAt:0];
    } error:nil];
    
    return nSum;
}

- (UInt64)sumIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition
                       params:(NSDictionary *)whereConditionParams {
    NSString *sqlString = [NSString stringWithFormat:@"SELECT TOTAL(%@) AS sum FROM %@ WHERE %@ ;", column, self.tableName, whereCondition];
    
    __block UInt64 nSum = 0;
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [whereConditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        nSum = [statement takeIntColumnAt:0];
    } error:nil];
    
    return nSum;
}

- (double)sumDoubleValueOfColumn:(NSString *)column {
    return [self sumDoubleValueOfColumn:column where:@""];
}

- (double)sumDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition {
    NSString *whereCaluse = @"";
    
    if (whereCondition && ![whereCondition isEqualToString:@""]) {
        whereCaluse = [NSString stringWithFormat:@" WHERE %@ ",whereCondition];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT TOTAL(%@) AS sum FROM %@ %@ ;", column, self.tableName, whereCaluse];
    
    __block double dSum = 0.0;
    
    [self.dbConnect executeSQL:sqlString bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        dSum = [statement takeDoubleColumnAt:0];
    } error:nil];
    
    return dSum;
}

- (double)sumDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition
                          params:(NSDictionary *)whereConditionParams {
    NSString *sqlString = [NSString stringWithFormat:@"SELECT TOTAL(%@) AS sum FROM %@ WHERE %@ ;", column, self.tableName, whereCondition];
    
    __block double dSum = 0.0;
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [whereConditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        dSum = [statement takeDoubleColumnAt:0];
    } error:nil];
    
    return dSum;
}

#pragma mark - avg function
- (double)avgDoubleValueOfColumn:(NSString *)column {
    return [self avgDoubleValueOfColumn:column where:@""];
}

- (double)avgDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition {
    NSString *whereCaluse = @"";
    
    if (whereCondition && ![whereCondition isEqualToString:@""]) {
        whereCaluse = [NSString stringWithFormat:@" WHERE %@ ",whereCondition];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT AVG(%@) AS avg FROM %@ %@ ;", column, self.tableName, whereCaluse];
    
    __block double dAvg = 0.0;
    
    [self.dbConnect executeSQL:sqlString bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        dAvg = [statement takeDoubleColumnAt:0];
    } error:nil];
    
    return dAvg;
}

- (double)avgDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition
                          params:(NSDictionary *)whereConditionParams {
    NSString *sqlString = [NSString stringWithFormat:@"SELECT AVG(%@) AS avg FROM %@ WHERE %@ ;", column, self.tableName, whereCondition];
    
    __block double dAvg = 0.0;
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [whereConditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        dAvg = [statement takeDoubleColumnAt:0];
    } error:nil];
    
    return dAvg;
}

@end

