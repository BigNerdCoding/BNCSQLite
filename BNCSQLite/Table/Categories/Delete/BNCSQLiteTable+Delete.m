//
//  BNCSQLiteTable+Delete.m
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/3.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteTable+Delete.h"
#import "BNCSQLiteDatabaseStatement+Bind.h"

@implementation BNCSQLiteTable (Delete)

- (BOOL)deleteRecord:(NSObject<BNCSQLiteRecordProtocol> * )record
               error:(NSError * __autoreleasing *)error {
    id rowID = [record valueForKey:self.primaryKeyName];
    
    return [self deleteWithPrimaryKey:rowID error:error];
}

- (BOOL)deleteRecordList:(NSArray <NSObject<BNCSQLiteRecordProtocol> * > *)recordList
                   error:(NSError * __autoreleasing*)error {
    
    __block BOOL isSuccess = YES;
    
    return [self.dbConnect executeSQLWithTransaction:^{
        
        for (id<BNCSQLiteRecordProtocol> record in recordList) {
            isSuccess = [self deleteRecord:record error:error];
            
            if (!isSuccess) {
                break;
            }
        }
        
        return isSuccess;
        
    } lockType:BNCSQLiteTransactionLockTypeDeferred];
}

- (BOOL)deleteWithCondition:(NSString *)whereCondition
                     params:(NSDictionary *)conditionParams
                      error:(NSError *__autoreleasing*)error {
    
    NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ ;", self.tableName, whereCondition];
    
    return [self.dbConnect executeSQL:deleteSQL bind:^(BNCSQLiteDatabaseStatement *statement) {
        [conditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:nil error:error];
}

- (BOOL)deleteWithPrimaryKey:(NSNumber *)primaryKeyValue
                       error:(NSError **)error {
    return [self deleteRecordWhereColumn:self.primaryKeyName value:primaryKeyValue error:error];
}

- (BOOL)deleteWithPrimaryKeyList:(NSArray <NSNumber *> *)primaryKeyValueList
                           error:(NSError *__autoreleasing*)error {
    __block BOOL isSuccess = YES;
    
    return [self.dbConnect executeSQLWithTransaction:^{
        
        for (NSNumber * rowID in primaryKeyValueList) {
            isSuccess = [self deleteWithPrimaryKey:rowID error:error];
            
            if (!isSuccess) {
                break;
            }
        }
        
        return isSuccess;
        
    } lockType:BNCSQLiteTransactionLockTypeDeferred];
}

- (BOOL)deleteRecordWhereColumn:(NSString *)column
                          value:(id)value
                          error:(NSError *__autoreleasing*)error {
    NSString *whereConditon = [NSString stringWithFormat:@"%@ = :%@", column, column];
    
    return [self deleteWithCondition:whereConditon params:@{column:value} error:error];
}

- (BOOL)deleteRecordWhereColumn:(NSString *)column
                    inValueList:(NSArray *)valueList
                          error:(NSError *__autoreleasing*)error {
    
    __block NSMutableArray *conditionValues = [NSMutableArray array];
    __block NSMutableDictionary *conditionValueBindList = [NSMutableDictionary dictionary];
    
    // Generate SQL
    [valueList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *bindKey = [NSString stringWithFormat:@":BNCSQLiteDeleteColumn%lu",(unsigned long)idx];
        [conditionValues addObject:bindKey];
        [conditionValueBindList setObject:obj forKey:bindKey];
    }];
    NSString *conditionValueSQL = [conditionValues componentsJoinedByString:@","];
    
    NSString *whereCondition = [NSString stringWithFormat:@" %@ IN (%@) ",column, conditionValueSQL];
    
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@;", self.tableName, whereCondition];
    
    return [self.dbConnect executeSQL:sqlString bind:^(BNCSQLiteDatabaseStatement *statement) {
        [conditionValueBindList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [statement bindColumn:key withValue:obj];
        }];
    } rowHandle:nil error:error];
}

- (BOOL)deleteRecordWhere:(NSString *)whereCondition error:(NSError *__autoreleasing*)error {
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@;", self.tableName, whereCondition];
    
    return [self.dbConnect executeSQL:sqlString bind:nil rowHandle:nil error:error];
}

- (BOOL)truncate {
    
    __block BOOL isSuccess = YES;
    
    return [self.dbConnect executeSQLWithTransaction:^{
        
        NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM %@;", self.tableName];
        
        isSuccess = [self.dbConnect executeSQL:sqlString bind:nil rowHandle:nil error:nil];
        
        if (!isSuccess) {
            return isSuccess;
        }
        
        sqlString = [NSString stringWithFormat:@"UPDATE sqlite_sequence SET seq = 0 WHERE name = '%@' ;", self.tableName];
        
        isSuccess = [self.dbConnect executeSQL:sqlString bind:nil rowHandle:nil error:nil];
        
        if (!isSuccess) {
            return isSuccess;
        }
        
        sqlString = @"VACUUM ;";
        
        [self.dbConnect executeSQL:sqlString bind:nil rowHandle:nil error:nil];
        
        return isSuccess;
        
    } lockType:BNCSQLiteTransactionLockTypeDeferred];
}

@end
