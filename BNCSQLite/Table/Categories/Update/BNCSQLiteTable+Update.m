//
//  BNCSQLiteTable+Update.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable+Update.h"
#import "BNCSQLiteDatabaseStatement+Bind.h"

@implementation BNCSQLiteTable (Update)

- (BOOL)updateRecord:(NSObject<BNCSQLiteRecordProtocol> *)record
               error:(NSError *__autoreleasing*)error {
    
    NSDictionary *recordDic = [record dictionaryRepresentationWithTable:self];
    
    return [self updateColumnValueList:recordDic primaryKey:[record valueForKey:self.primaryKeyName]  error:error];
}

- (BOOL)updateRecordList:(NSArray <NSObject<BNCSQLiteRecordProtocol> * > *)recordList
                   error:(NSError *__autoreleasing*)error {
    __block BOOL isSuccess = YES;
    
    return [self.dbConnect executeSQLWithTransaction:^{
        
        for (id<BNCSQLiteRecordProtocol> record in recordList) {
            isSuccess = [self updateRecord:record error:error];
            
            if (!isSuccess) {
                break;
            }
        }
        
        return isSuccess;
        
    } lockType:BNCSQLiteTransactionLockTypeDeferred];
}

- (BOOL)updateValue:(id)value
          forColumn:(NSString *)column
          condition:(NSString *)whereCondition
             params:(NSDictionary *)conditionParams
              error:(NSError *__autoreleasing*)error {
    
    return [self updateColumnValueList:@{column:value} condition:whereCondition params:conditionParams error:error];
}

- (BOOL)updateColumnValueList:(NSDictionary *)columnValueList
                    condition:(NSString *)whereCondition
                       params:(NSDictionary *)conditionParams
                        error:(NSError *__autoreleasing*)error {
    
    __block NSMutableArray *updateColumns = [NSMutableArray array];
    __block NSMutableDictionary *updateColumnBindList = [NSMutableDictionary dictionary];
    
    [columnValueList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *updateColumn = [NSString stringWithFormat:@" %@ = :BNCSQLiteUpdateColumn%@",key, key];
        [updateColumns addObject:updateColumn];
        [updateColumnBindList setObject:obj forKey:[NSString stringWithFormat:@":BNCSQLiteUpdateColumn%@", key]];
    }];
    
    NSString *updateValueSQL = [updateColumns componentsJoinedByString:@","];
    
    NSString *updateSQL = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ ;",self.tableName,updateValueSQL,whereCondition];
    
    return [self.dbConnect executeSQL:updateSQL bind:^(BNCSQLiteDatabaseStatement *statement) {
        [updateColumnBindList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [statement bindColumn:key withValue:obj];
        }];
        
        [conditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:nil error:error];
}

- (BOOL)updateValue:(id)value
          forColumn:(NSString *)column
           whereKey:(NSString *)wherekey
             inList:(NSArray *)valueList
              error:(NSError *__autoreleasing *)error {
    return [self updateColumnValueList:@{column:value} whereKey:wherekey inList:valueList error:error];
}

- (BOOL)updateColumnValueList:(NSDictionary *)columnValueList
                     whereKey:(NSString *)wherekey
                       inList:(NSArray *)valueList
                        error:(NSError *__autoreleasing *)error {
    
    // Update Column
    __block NSMutableArray *updateColumns = [NSMutableArray array];
    __block NSMutableDictionary *updateColumnBindList = [NSMutableDictionary dictionary];
    [columnValueList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *updateColumn = [NSString stringWithFormat:@" %@ = :BNCSQLiteUpdateColumn%@",key, key];
        [updateColumns addObject:updateColumn];
        [updateColumnBindList setObject:obj forKey:[NSString stringWithFormat:@":BNCSQLiteUpdateColumn%@", key]];
    }];
    
    NSString *updateValueSQL = [updateColumns componentsJoinedByString:@","];
    
    // Update Condition
    __block NSMutableArray *conditionValues = [NSMutableArray array];
    __block NSMutableDictionary *conditionValueBindList = [NSMutableDictionary dictionary];
    
    [valueList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *bindKey = [NSString stringWithFormat:@":BNCSQLiteWhrerColumn%lu",(unsigned long)idx];
        [conditionValues addObject:bindKey];
        [conditionValueBindList setObject:obj forKey:bindKey];
    }];
    NSString *conditionValueSQL = [conditionValues componentsJoinedByString:@","];
    
    // Where clause
    NSString *whereCondition = [NSString stringWithFormat:@" %@ IN (%@) ",wherekey, conditionValueSQL];
    
    // SQL
    NSString *updateSQL = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ ;",self.tableName, updateValueSQL, whereCondition];
    
    return [self.dbConnect executeSQL:updateSQL bind:^(BNCSQLiteDatabaseStatement *statement) {
        
        // Bind Update Column
        [updateColumnBindList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [statement bindColumn:key withValue:obj];
        }];
        
        // Bind Update Condition
        [conditionValueBindList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [statement bindColumn:key withValue:obj];
        }];
        
    } rowHandle:nil error:error];
}

- (BOOL)updateValue:(id)value
          forColumn:(NSString *)column
         primaryKey:(NSNumber *)primaryKey
              error:(NSError *__autoreleasing*)error {
    
    return [self updateColumnValueList:@{column:value} primaryKey:primaryKey error:error];
}

- (BOOL)updateColumnValueList:(NSDictionary *)columnValueList
                   primaryKey:(NSNumber *)primaryKey
                        error:(NSError *__autoreleasing*)error {
    
    NSString *whereCondition = [NSString stringWithFormat:@"%@ = :%@", self.primaryKeyName, self.primaryKeyName];
    
    return [self updateColumnValueList:columnValueList condition:whereCondition params:@{self.primaryKeyName:primaryKey} error:error];
}

- (BOOL)updateValue:(id)value
          forColumn:(NSString *)column
              error:(NSError *__autoreleasing*)error {
    return [self updateValue:value forColumn:column whereCondition:@"" error:error];
}

- (BOOL)updateValue:(id)value
          forColumn:(NSString *)column
     whereCondition:(NSString *)whereCondition
              error:(NSError *__autoreleasing*)error{
    return [self updateColumnValueList:@{column:value} whereCondition:whereCondition error:error];
}

- (BOOL)updateColumnValueList:(NSDictionary *)columnValueList
                        error:(NSError *__autoreleasing*)error {
    return [self updateColumnValueList:columnValueList whereCondition:@"" error:error];
}

- (BOOL)updateColumnValueList:(NSDictionary *)columnValueList
               whereCondition:(NSString *)whereCondition
                        error:(NSError *__autoreleasing*)error {
    
    __block NSMutableArray *updateColumns = [NSMutableArray array];
    __block NSMutableDictionary *updateColumnBindList = [NSMutableDictionary dictionary];
    
    [columnValueList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *updateColumn = [NSString stringWithFormat:@" %@ = :BNCSQLiteUpdateColumn%@",key, key];
        [updateColumns addObject:updateColumn];
        [updateColumnBindList setObject:obj forKey:[NSString stringWithFormat:@":BNCSQLiteUpdateColumn%@", key]];
    }];
    
    NSString *updateValueSQL = [updateColumns componentsJoinedByString:@","];
    
    NSString *whereClause = @"";
    
    if (whereCondition && ![whereCondition isEqualToString:@""]) {
        whereClause = [NSString stringWithFormat:@" WHERE %@", whereCondition];
    }
    
    NSString *updateSQL = [NSString stringWithFormat:@"UPDATE %@ SET %@ %@ ;",self.tableName,updateValueSQL,whereClause];
    
    return [self.dbConnect executeSQL:updateSQL bind:^(BNCSQLiteDatabaseStatement *statement) {
        [updateColumnBindList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [statement bindColumn:key withValue:obj];
        }];
    } rowHandle:nil error:error];
}

@end
