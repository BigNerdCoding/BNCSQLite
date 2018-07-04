//
//  BNCSQLiteTable+Find.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable.h"
#import "BNCSQLiteRecordProtocol.h"

@interface BNCSQLiteTable (Find)

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithError:(NSError *__autoreleasing*)error;

- (id<BNCSQLiteRecordProtocol>)findLatestRecordWithError:(NSError *__autoreleasing*)error;

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithWhereCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams isDistinct:(BOOL)isDistinct error:(NSError *__autoreleasing*)error;

/**
 *  find all record with sql string. sqlString can be bind with params like where condition. @see - (void)deleteWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams error:(NSError **)error: for how to use where condition.
 *
 *  @param sqlString the sqlString for finding all records
 *  @param params    the params to be bind into sqlString
 *  @param error     error if fails
 *
 *  @return return the record list
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithSQL:(NSString *)sqlString params:(NSDictionary *)params error:(NSError *__autoreleasing*)error;

/**
 *  find first row in record list with where condition.  @see - (void)deleteWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams error:(NSError **)error: for how to use where condition. First row means the first record of fetched record list, not the first record in table.
 *
 *  @param condition       condition used in WHERE clause
 *  @param conditionParams params to bind into whereCondition
 *  @param isDistinct      if YES, will use 'SELECT DISTINCT' clause
 *  @param error           error if fails
 *
 *  @return return a record
 */
- (id<BNCSQLiteRecordProtocol>)findFirstRowWithWhereCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams isDistinct:(BOOL)isDistinct error:(NSError *__autoreleasing*)error;

/**
 *  return total record count in this table
 *
 *  @return return total record count in this table
 */
- (NSInteger)countTotalRecord;

/**
 *  record count of record list with matches where condition. @see deleteWithWhereCondition:conditionParams:error: for how to use where condition.
 *
 *  @param whereCondition  condition used in WHERE clause
 *  @param conditionParams params ro bind into whereCondition
 *  @param error           error if fails
 *
 *  @return return record count of record list with matches where condition.
 */
- (NSInteger)countWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams error:(NSError *__autoreleasing*)error;

/**
 *  find a record with primary key.
 *
 *  @param primaryKeyValue the primary key of the record you want to find
 *  @param error           error if fails
 *
 *  @return return a record
 */
- (id<BNCSQLiteRecordProtocol>)findWithPrimaryKey:(NSNumber *)primaryKeyValue error:(NSError *__autoreleasing*)error;

/**
 *  find all keyname's value equal to value
 *
 *  @param keyname key name
 *  @param value   value of key name
 *  @param error   error if fails
 *
 *  @return return a list of record
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithKeyName:(NSString *)keyname value:(id)value error:(NSError *__autoreleasing*)error;


/**
 *  find all keyname's value equal to value
 *
 *  @param keyname      key name
 *  @param valueList    a list of value
 *  @param error        error if fails
 *
 *  @return return a list of record
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithKeyName:(NSString *)keyname inValueList:(NSArray *)valueList error:(NSError *__autoreleasing*)error;


@end
