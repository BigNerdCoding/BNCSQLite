//
//  BNCSQLiteTable+Delete.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable.h"
#import "BNCSQLiteRecordProtocol.h"

@interface BNCSQLiteTable (Delete)

- (BOOL)deleteRecord:(NSObject<BNCSQLiteRecordProtocol> * )record error:(NSError * __autoreleasing *)error;

- (BOOL)deleteRecordList:(NSArray <NSObject<BNCSQLiteRecordProtocol> * > *)recordList error:(NSError * __autoreleasing*)error;

/**
 *  delete with condition. The "where condition" is a string which will be used in SQL WHERE clause. Can bind params if you have words start with colon.
 *
 *  Example for whereCondition and conditionParams:
 *
 *      NSString *whereCondition = @"hello = :something"; // the key in string must start wich colon
 *
 *      NSDictionary *conditionParams = @{
 *
 *          @"something":@"world"
 *
 *      };// the where string will be "hello = world"
 *
 *  @param whereCondition  the string for WHERE clause
 *  @param conditionParams the params to bind in to where condition
 *  @param error           the error if delete fails
 */
- (BOOL)deleteWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams error:(NSError *__autoreleasing*)error;

- (BOOL)deleteWithPrimaryKey:(NSNumber *)primaryKeyValue error:(NSError *__autoreleasing*)error;

- (BOOL)deleteWithPrimaryKeyList:(NSArray <NSNumber *> *)primaryKeyValueList error:(NSError * __autoreleasing*)error;

- (BOOL)deleteRecordWhereKey:(NSString *)key value:(id)value error:(NSError *__autoreleasing*)error;

- (BOOL)truncate;

@end
