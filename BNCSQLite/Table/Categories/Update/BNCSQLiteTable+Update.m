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

- (BOOL)updateRecord:(NSObject<BNCSQLiteRecordProtocol> *)record error:(NSError *__autoreleasing*)error {
    NSDictionary *recordDic = [record dictionaryRepresentationWithTable:self];
    
    return [self updateKeyValueList:recordDic primaryKeyValue:[record valueForKey:self.primaryKeyName]  error:error];
}

- (BOOL)updateRecordList:(NSArray <NSObject<BNCSQLiteRecordProtocol> * > *)recordList error:(NSError * __autoreleasing *)error {
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

- (BOOL)updateValue:(id)value forKey:(NSString *)key whereCondition:(NSString *)whereCondition whereConditionParams:(NSDictionary *)whereConditionParams error:(NSError *__autoreleasing*)error {
    
    return [self updateKeyValueList:@{key:value} whereCondition:whereCondition whereConditionParams:whereConditionParams error:error];
}

- (BOOL)updateKeyValueList:(NSDictionary *)keyValueList whereCondition:(NSString *)whereCondition whereConditionParams:(NSDictionary *)whereConditionParams error:(NSError *__autoreleasing*)error {
    
    __block NSMutableArray *updateColumns = [NSMutableArray array];
    __block NSMutableDictionary *updateColumnBindList = [NSMutableDictionary dictionary];
    
    [keyValueList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *updateColumn = [NSString stringWithFormat:@" %@ = :BNCSQLiteUpdateColum%@",key, key];
        [updateColumns addObject:updateColumn];
        [updateColumnBindList setObject:obj forKey:[NSString stringWithFormat:@":BNCSQLiteUpdateColum%@", key]];
    }];
    
    NSString *updateValueSQL = [updateColumns componentsJoinedByString:@","];
    
    NSString *updateSQL = [NSString stringWithFormat:@"UPDATE '%@' SET %@ WHERE %@;",self.tableName,updateValueSQL,whereCondition];
    
    return [self.dbConnect executeSQL:updateSQL bind:^(BNCSQLiteDatabaseStatement *statement) {
        [updateColumnBindList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [statement bindColumn:key withValue:obj];
        }];
        
        
        [whereConditionParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [statement bindColumn:key withValue:obj];
        }];
    } rowHandle:nil error:error];
}

- (BOOL)updateValue:(id)value forKey:(NSString *)key whereKey:(NSString *)wherekey inList:(NSArray *)valueList error:(NSError *__autoreleasing *)error {
    
    __block NSMutableArray *conditionValues = [NSMutableArray array];
    __block NSMutableDictionary *conditionValueBindList = [NSMutableDictionary dictionary];
    
    [valueList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *bindKey = [NSString stringWithFormat:@":BNCSQLiteUpdateColum%lu",(unsigned long)idx];
        [conditionValues addObject:bindKey];
        [conditionValueBindList setObject:obj forKey:bindKey];
    }];
    NSString *conditionValueSQL = [conditionValues componentsJoinedByString:@","];
    
    NSString *whereCondition = [NSString stringWithFormat:@" %@ IN (%@) ",wherekey, conditionValueSQL];
    
    NSString *updateSQL = [NSString stringWithFormat:@"UPDATE '%@' SET %@ = :%@ WHERE %@;",self.tableName, key, key, whereCondition];
    
    return [self.dbConnect executeSQL:updateSQL bind:^(BNCSQLiteDatabaseStatement *statement) {
        
        [statement bindColumn:[NSString stringWithFormat:@":%@",key] withValue:value];
    
        [conditionValueBindList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [statement bindColumn:key withValue:obj];
        }];
        
    } rowHandle:nil error:error];
    
    return YES;
}

- (BOOL)updateValue:(id)value forKey:(NSString *)key primaryKeyValue:(NSNumber *)primaryKeyValue error:(NSError *__autoreleasing*)error {
    return [self updateKeyValueList:@{key:value} primaryKeyValue:primaryKeyValue error:error];
}

- (BOOL)updateKeyValueList:(NSDictionary *)keyValueList primaryKeyValue:(NSNumber *)primaryKeyValue error:(NSError *__autoreleasing*)error {
    NSString *whereCondition = [NSString stringWithFormat:@"%@ = :%@", self.primaryKeyName, self.primaryKeyName];
    
    return [self updateKeyValueList:keyValueList whereCondition:whereCondition whereConditionParams:@{[NSString stringWithFormat:@":%@",self.primaryKeyName]:primaryKeyValue} error:error];
}

@end
