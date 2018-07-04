//
//  BNCSQLiteTable+Update.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable.h"
#import "BNCSQLiteRecordProtocol.h"

@interface BNCSQLiteTable (Update)

/**
 *  update a record
 *
 *  @param record the record you want to update
 *  @param error  error if fails
 */
- (BOOL)updateRecord:(NSObject<BNCSQLiteRecordProtocol> *)record error:(NSError *__autoreleasing*)error;

/**
 *  udpate a list of record
 *
 *  @param recordList the list of record to update
 *  @param error      error if fails
 */
- (BOOL)updateRecordList:(NSArray <NSObject<BNCSQLiteRecordProtocol> * > *)recordList error:(NSError *__autoreleasing*)error;

/**
 *  update value for key which the row matches whereCondition, @see deleteWithWhereCondition:conditionParams:error:
 *
 *  @param value                the value to update
 *  @param key                  the key of the column to update
 *  @param whereCondition       where condition
 *  @param whereConditionParams params for where condition
 *  @param error                error if fails
 */
- (BOOL)updateValue:(id)value forKey:(NSString *)key whereCondition:(NSString *)whereCondition whereConditionParams:(NSDictionary *)whereConditionParams error:(NSError *__autoreleasing*)error;

/**
 *  update keys and values of rows matches whereCondition, @see deleteWithWhereCondition:conditionParams:error:
 *
 *  @param keyValueList         key-values to update
 *  @param whereCondition       where contidition
 *  @param whereConditionParams params for where condition
 *  @param error                error if fails
 */
- (BOOL)updateKeyValueList:(NSDictionary *)keyValueList whereCondition:(NSString *)whereCondition whereConditionParams:(NSDictionary *)whereConditionParams error:(NSError *__autoreleasing*)error;

/**
 *  update value for key1, where key2 in a list
 *
 *  @param value        value to update
 *  @param key          key for value to update
 *  @param wherekey     keyname to search
 *  @param valueList    keyname's value list
 *  @param error        error if fails
 */
- (BOOL)updateValue:(id)value forKey:(NSString *)key whereKey:(NSString *)wherekey inList:(NSArray *)valueList error:(NSError *__autoreleasing *)error;

/**
 *  update value for key by primary key
 *
 *  @param value           value to update
 *  @param key             key to update
 *  @param primaryKeyValue primary key of the record you want to update
 *  @param error           error if fails
 */
- (BOOL)updateValue:(id)value forKey:(NSString *)key primaryKeyValue:(NSNumber *)primaryKeyValue error:(NSError *__autoreleasing*)error;

/**
 *  update key-value list by primary key of the record you want to update
 *
 *  @param keyValueList    key-value list to update
 *  @param primaryKeyValue the primary key of the record you want to update
 *  @param error           error if fails
 */
- (BOOL)updateKeyValueList:(NSDictionary *)keyValueList primaryKeyValue:(NSNumber *)primaryKeyValue error:(NSError *__autoreleasing*)error;

@end
