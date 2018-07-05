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
 update a record

 @param record record need update
 @param error error if fails
 @return whether the update action is success
 */
- (BOOL)updateRecord:(NSObject<BNCSQLiteRecordProtocol> *)record
               error:(NSError *__autoreleasing*)error;

/**
 update a list of record

 @param recordList the list of record to update
 @param error error if fails
 @return whether the update action is success
 */
- (BOOL)updateRecordList:(NSArray <NSObject<BNCSQLiteRecordProtocol> * > *)recordList
                   error:(NSError *__autoreleasing*)error;

/**
 update value for column which the row matches whereCondition

 @see - (BOOL)deleteWithCondition:(NSString *)whereCondition
                           params:(NSDictionary *)conditionParams
                            error:(NSError *__autoreleasing*)error
 
 for how to use where condition.
 
 @param value the value to update
 @param column the column to update
 @param whereCondition string for WHERE clause
 @param conditionParams the params to bind in to where condition
 @param error error if fails
 @return whether the update action is success
 */
- (BOOL)updateValue:(id)value
             forColumn:(NSString *)column
          condition:(NSString *)whereCondition
             params:(NSDictionary *)conditionParams
              error:(NSError *__autoreleasing*)error;

/**
 update column values of rows that matches whereCondition

 @see - (BOOL)deleteWithCondition:(NSString *)whereCondition
                           params:(NSDictionary *)conditionParams
                            error:(NSError *__autoreleasing*)error
 
 for how to use where condition.
 
 @param columnValueList column-values to update
 @param whereCondition string for WHERE clause
 @param conditionParams the params to bind in to where condition
 @param error error if fails
 @return whether the update action is success
 */
- (BOOL)updateColumnValueList:(NSDictionary *)columnValueList
                    condition:(NSString *)whereCondition
                       params:(NSDictionary *)conditionParams
                        error:(NSError *__autoreleasing*)error;

/**
 update value for column, where column `wherekey` in a list

 @param value value to update
 @param column column need update
 @param wherekey column to search
 @param valueList column's value list
 @param error error if fails
 @return whether the update action is success
 */
- (BOOL)updateValue:(id)value
          forColumn:(NSString *)column
           whereKey:(NSString *)wherekey
             inList:(NSArray *)valueList
              error:(NSError *__autoreleasing *)error;

/**
 update value for column by primary key

 @param value value to update
 @param column column need update
 @param primaryKey primary key of the record you want to update
 @param error error if fails
 @return whether the update action is success
 */
- (BOOL)updateValue:(id)value
          forColumn:(NSString *)column
         primaryKey:(NSNumber *)primaryKey
              error:(NSError *__autoreleasing*)error;

/**
 update column values of rows that primaryKey cloumn value equal 'primaryKey'

 @param columnValueList column-values to update
 @param primaryKey primary key of the record you want to update
 @param error error if fails
 @return whether the update action is success
 */
- (BOOL)updateColumnValueList:(NSDictionary *)columnValueList
                   primaryKey:(NSNumber *)primaryKey
                     error:(NSError *__autoreleasing*)error;

@end