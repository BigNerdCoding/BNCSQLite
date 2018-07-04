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

- (BOOL)deleteRecord:(id<BNCSQLiteRecordProtocol>)record error:(NSError **)error;

- (BOOL)deleteRecordList:(NSArray <id<BNCSQLiteRecordProtocol> > *)recordList error:(NSError **)error;

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
- (BOOL)deleteWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams error:(NSError **)error;

- (BOOL)deleteWithPrimaryKey:(NSNumber *)primaryKeyValue error:(NSError **)error;

- (BOOL)deleteRecordWhereKey:(NSString *)key value:(id)value error:(NSError **)error;

- (BOOL)truncate;

@end
