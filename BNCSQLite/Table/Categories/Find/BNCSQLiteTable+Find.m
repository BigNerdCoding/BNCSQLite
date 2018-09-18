//
//  BNCSQLiteTable+Find.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable+Find.h"
#import "BNCSQLiteDatabaseStatement+Bind.h"
#import "BNCSQLiteDatabaseStatement+Take.h"

@implementation BNCSQLiteTable (Find)

#pragma mark - Query without condition
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithError:(NSError *__autoreleasing*)error {
    return [self findAllWithOrder:@"" error:error];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithOrder:(NSString *)orderBy
                                                       error:(NSError *__autoreleasing*)error {
    
    NSString *orderClause = @"";
    
    if (orderBy && ![orderBy isEqualToString:@""]) {
        orderClause = [NSString stringWithFormat:@" ORDER BY %@ ",orderBy];
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@ ;", self.tableName, orderClause];
    
    __block NSMutableArray *results = [NSMutableArray array];
    [self.dbConnect executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dictionary = [statement takeAllColumn];
        id<BNCSQLiteRecordProtocol> record = [[self.recordClass alloc] init];
        
        if ([record respondsToSelector:@selector(objectRepresentationWithDictionary:)]) {
            [record objectRepresentationWithDictionary:dictionary];
            [results addObject:record];
        }
    } error:error];
    
    return results;
}

- (id<BNCSQLiteRecordProtocol>)findLatestRecordWithError:(NSError *__autoreleasing*)error {
    return [[self findAllWithError:error] lastObject];
}

- (id<BNCSQLiteRecordProtocol>)findLatestRecordWithOrder:(NSString *)orderBy
                                                   error:(NSError *__autoreleasing*)error {
    return [[self findAllWithOrder:orderBy error:error] lastObject];
}

#pragma mark - Query with single column equal condition

- (id<BNCSQLiteRecordProtocol>)findWithPrimaryKey:(NSNumber *)primaryKey
                                            error:(NSError *__autoreleasing*)error {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@=:%@ ;", self.tableName, self.primaryKeyName, self.primaryKeyName];
    
    __block id<BNCSQLiteRecordProtocol> record = nil;
    
    [self.dbConnect executeSQL:sql bind:^(BNCSQLiteDatabaseStatement *statement) {
        NSString *bindKey = [NSString stringWithFormat:@":%@",self.primaryKeyName];
        [statement bindColumn:bindKey withValue:primaryKey];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dictionary = [statement takeAllColumn];
        record = [[self.recordClass alloc] init];
        if ([record respondsToSelector:@selector(objectRepresentationWithDictionary:)]) {
            [record objectRepresentationWithDictionary:dictionary];
        } else {
            record = nil;
        }
        
    } error:error];
    
    return record;
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithColumn:(NSString *)column
                                                        value:(id)value
                                                        error:(NSError *__autoreleasing*)error {
    return [self findAllWithColumn:column value:value orderBy:@"" error:error];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithColumn:(NSString *)column
                                                        value:(id)value
                                                      orderBy:(NSString *)orderBy
                                                        error:(NSError *__autoreleasing*)error {
    NSString *orderClause = @"";
    
    if (orderBy && ![orderBy isEqualToString:@""]) {
        orderClause = [NSString stringWithFormat:@" ORDER BY %@ ",orderBy];
    }
    
    NSString *whereCondition = [NSString stringWithFormat:@" %@=:%@ ",column,column];
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ %@ ;", self.tableName, whereCondition, orderClause];
    
    // Execute SQL
    __block NSMutableArray *results = [NSMutableArray array];
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [statement bindColumn:[NSString stringWithFormat:@":%@",column] withValue:value];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dictionary = [statement takeAllColumn];
        id<BNCSQLiteRecordProtocol> record = [[self.recordClass alloc] init];
        
        if ([record respondsToSelector:@selector(objectRepresentationWithDictionary:)]) {
            [record objectRepresentationWithDictionary:dictionary];
            [results addObject:record];
        }
    } error:error];
    
    return results;
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithColumn:(NSString *)column
                                                  inValueList:(NSArray *)valueList
                                                        error:(NSError *__autoreleasing*)error {
    return [self findAllWithColumn:column inValueList:valueList orderBy:@"" error:error];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithColumn:(NSString *)column
                                                  inValueList:(NSArray *)valueList
                                                      orderBy:(NSString *)orderBy
                                                        error:(NSError *__autoreleasing*)error {
    
    __block NSMutableArray *conditionValues = [NSMutableArray array];
    __block NSMutableDictionary *conditionValueBindList = [NSMutableDictionary dictionary];
    
    // Generate SQL
    [valueList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *bindKey = [NSString stringWithFormat:@":BNCSQLiteUpdateColum%lu",(unsigned long)idx];
        [conditionValues addObject:bindKey];
        [conditionValueBindList setObject:obj forKey:bindKey];
    }];
    NSString *conditionValueSQL = [conditionValues componentsJoinedByString:@","];
    
    NSString *whereCondition = [NSString stringWithFormat:@" %@ IN (%@) ",column, conditionValueSQL];
    
    NSString *orderClause = @"";
    
    if (orderBy && ![orderBy isEqualToString:@""]) {
        orderClause = [NSString stringWithFormat:@" ORDER BY %@ ",orderBy];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ %@;",self.tableName,whereCondition,orderClause];
    
    // Execute SQL
    __block NSMutableArray *results = [NSMutableArray array];
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [conditionValueBindList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [statement bindColumn:key withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dictionary = [statement takeAllColumn];
        id<BNCSQLiteRecordProtocol> record = [[self.recordClass alloc] init];
        
        if ([record respondsToSelector:@selector(objectRepresentationWithDictionary:)]) {
            [record objectRepresentationWithDictionary:dictionary];
            [results addObject:record];
        }
    } error:error];
    
    return results;
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithColumn:(NSString *)column
                                                           value:(id)value
                                                           limit:(NSUInteger)limit
                                                           error:(NSError *__autoreleasing*)error {
    return [self findRecordWithColumn:column value:value orderBy:@"" limit:limit error:error];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithColumn:(NSString *)column
                                                           value:(id)value
                                                         orderBy:(NSString *)orderBy
                                                           limit:(NSUInteger)limit
                                                           error:(NSError *__autoreleasing*)error {
    NSString *orderClause = @"";
    
    if (orderBy && ![orderBy isEqualToString:@""]) {
        orderClause = [NSString stringWithFormat:@" ORDER BY %@ ",orderBy];
    }
    
     NSString *limitClause = @"";
    if (limit > 0) {
        limitClause = [NSString stringWithFormat:@" LIMIT %lu", (unsigned long)limit];
    }
    
    NSString *whereCondition = [NSString stringWithFormat:@" %@=:%@ ",column,column];
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ %@ %@;", self.tableName, whereCondition, orderClause, limitClause];
    
    // Execute SQL
    __block NSMutableArray *results = [NSMutableArray array];
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [statement bindColumn:[NSString stringWithFormat:@":%@",column] withValue:value];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dictionary = [statement takeAllColumn];
        id<BNCSQLiteRecordProtocol> record = [[self.recordClass alloc] init];
        
        if ([record respondsToSelector:@selector(objectRepresentationWithDictionary:)]) {
            [record objectRepresentationWithDictionary:dictionary];
            [results addObject:record];
        }
    } error:error];
    
    return results;
}

#pragma mark - Query without mulit column condition

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithCondition:(NSString *)whereCondition
                                                          params:(NSDictionary *)conditionParams
                                                           error:(NSError *__autoreleasing*)error {
    return [self findAllWithCondition:whereCondition params:conditionParams orderBy:@"" error:error];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithCondition:(NSString *)whereCondition
                                                          params:(NSDictionary *)conditionParams
                                                         orderBy:(NSString *)orderBy
                                                           error:(NSError *__autoreleasing*)error {
    
    NSString *orderClause = @"";
    
    if (orderBy && ![orderBy isEqualToString:@""]) {
        orderClause = [NSString stringWithFormat:@" ORDER BY %@ ",orderBy];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ %@ ;", self.tableName, whereCondition, orderClause];
    
    __block NSMutableArray *results = [NSMutableArray array];

    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [conditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        NSDictionary *dictionary = [statement takeAllColumn];
        id<BNCSQLiteRecordProtocol> record = [[self.recordClass alloc] init];
        
        if ([record respondsToSelector:@selector(objectRepresentationWithDictionary:)]) {
            [record objectRepresentationWithDictionary:dictionary];
            [results addObject:record];
        }
    } error:error];
    
    return results;
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithCondition:(NSString *)whereCondition
                                                             params:(NSDictionary *)conditionParams
                                                              limit:(NSUInteger)limit
                                                              error:(NSError *__autoreleasing*)error {
    return [self findRecordWithCondition:whereCondition params:conditionParams orderBy:@"" limit:limit error:error];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithCondition:(NSString *)whereCondition
                                                             params:(NSDictionary *)conditionParams
                                                            orderBy:(NSString *)orderBy
                                                              limit:(NSUInteger)limit
                                                              error:(NSError *__autoreleasing*)error {
    NSString *orderClause = @"";
    
    if (orderBy && ![orderBy isEqualToString:@""]) {
        orderClause = [NSString stringWithFormat:@" ORDER BY %@ ",orderBy];
    }
    
    NSString *limitClause = @"";
    
    if (limit > 0) {
        limitClause = [NSString stringWithFormat:@" LIMIT %lu", (unsigned long)limit];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ %@ %@ ;", self.tableName, whereCondition, orderClause, limitClause];
    
    __block NSMutableArray *results = [NSMutableArray array];
    
    [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [conditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        NSDictionary *dictionary = [statement takeAllColumn];
        id<BNCSQLiteRecordProtocol> record = [[self.recordClass alloc] init];
        
        if ([record respondsToSelector:@selector(objectRepresentationWithDictionary:)]) {
            [record objectRepresentationWithDictionary:dictionary];
            [results addObject:record];
        }
    } error:error];
    
    return results;
}

#pragma mark - Query with Ready whereCondition

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithWhere:(NSString *)whereCondition
                                                       error:(NSError *__autoreleasing*)error {
    return [self findAllWithWhere:whereCondition orderBy:@"" error:error];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithWhere:(NSString *)whereCondition
                                                     orderBy:(NSString *)orderBy
                                                       error:(NSError *__autoreleasing*)error {
    return [self findRecordWithWhere:whereCondition orderBy:orderBy limit:0 error:error];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithWhere:(NSString *)whereCondition
                                                          limit:(NSUInteger)limit
                                                          error:(NSError *__autoreleasing*)error {
    return [self findRecordWithWhere:whereCondition orderBy:@"" limit:limit error:error];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithWhere:(NSString *)whereCondition
                                                        orderBy:(NSString *)orderBy
                                                          limit:(NSUInteger)limit
                                                          error:(NSError *__autoreleasing*)error {
    NSString *orderClause = @"";
    
    if (orderBy && ![orderBy isEqualToString:@""]) {
        orderClause = [NSString stringWithFormat:@" ORDER BY %@ ",orderBy];
    }
    
    NSString *limitClause = @"";
    
    if (limit > 0) {
        limitClause = [NSString stringWithFormat:@" LIMIT %lu", (unsigned long)limit];
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ %@ %@ ;", self.tableName, whereCondition, orderClause, limitClause];
    
    __block NSMutableArray *results = [NSMutableArray array];
    
    [self.dbConnect executeSQL:sqlString bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        NSDictionary *dictionary = [statement takeAllColumn];
        id<BNCSQLiteRecordProtocol> record = [[self.recordClass alloc] init];
        
        if ([record respondsToSelector:@selector(objectRepresentationWithDictionary:)]) {
            [record objectRepresentationWithDictionary:dictionary];
            [results addObject:record];
        }
    } error:error];
    
    return results;
}

#pragma mark - General Table Info Query

- (UInt64)countTotalRecord {
    NSString *sqlString = [NSString stringWithFormat:@"SELECT COUNT(*) AS count FROM %@ ;", self.tableName];
    
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

@end
