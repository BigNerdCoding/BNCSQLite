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

/**
 delete a record

 @param record the instance you want to delete
 @param error the error if delete fails
 @return whether the delete action is success
 */
- (BOOL)deleteRecord:(NSObject<BNCSQLiteRecordProtocol> * )record
               error:(NSError * __autoreleasing *)error;

/**
 delete a list of record

 @param recordList recordList you want to delete
 @param error the error if delete fails
 @return whether the delete action is success
 */
- (BOOL)deleteRecordList:(NSArray <NSObject<BNCSQLiteRecordProtocol> * > *)recordList
                   error:(NSError * __autoreleasing*)error;

/**
 delete with condition. The "where condition" is a string which will be used in SQL WHERE clause. Can bind params if you have words start with colon.
 
 Example for whereCondition and conditionParams:
 
    NSString *whereCondition = @"hello = :something"; // the key in string must start wich colon
 
    NSDictionary *conditionParams = @{
        @"something":@"world"
    };// the where string will be "hello = world"

 @param whereCondition  the string for WHERE clause
 @param conditionParams the params to bind in to where condition
 @param error the error if delete fails
 @return whether the delete action is success
 */
- (BOOL)deleteWithCondition:(NSString *)whereCondition
                     params:(NSDictionary *)conditionParams
                      error:(NSError *__autoreleasing*)error;

/**
 delete record with parimary key

 @param primaryKeyValue the primary key of record to be deleted
 @param error error if delete fails
 @return whether the delete action is success
 */
- (BOOL)deleteWithPrimaryKey:(NSNumber *)primaryKeyValue
                       error:(NSError *__autoreleasing*)error;

/**
 delete a list record by primary key list

 @param primaryKeyValueList the primary key list
 @param error error if delete fails
 @return whether the delete action is success
 */
- (BOOL)deleteWithPrimaryKeyList:(NSArray <NSNumber *> *)primaryKeyValueList
                           error:(NSError * __autoreleasing*)error;

/**
 delete a record in table where key = value

 @param column the column name in where condition
 @param value the column value to be deleted
 @param error error if delete fails
 @return whether the delete action is success
 */
- (BOOL)deleteRecordWhereColumn:(NSString *)column
                          value:(id)value
                          error:(NSError *__autoreleasing*)error;

/**
 delete some record in table where key IN (inValueList)

 @param column the column name in where condition
 @param valueList column's value list
 @param error error if delete fails
 @return whether the delete action is success
 */
- (BOOL)deleteRecordWhereColumn:(NSString *)column
                    inValueList:(NSArray *)valueList
                          error:(NSError *__autoreleasing*)error;

/**
 truncate the table

 @return whether the truncate action is success
 */
- (BOOL)truncate;

@end
