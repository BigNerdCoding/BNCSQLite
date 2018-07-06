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

#pragma mark - Query without condition
/**
 query all record without order

 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithError:(NSError *__autoreleasing*)error;

/**
 query all record without order

 Example:
    [table findAllWithOrder:@"score ASC"]
    [table findAllWithOrder:@"score ASC, price DESC"]
 
 @param orderBy string for ORDER BY clause
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithOrder:(NSString *)orderBy
                                                       error:(NSError *__autoreleasing*)error;

/**
 query latest record without order

 @param error  error if fails
 @return query result (may be nil)
 */
- (id<BNCSQLiteRecordProtocol>)findLatestRecordWithError:(NSError *__autoreleasing*)error;

/**
 query latest record with order

 Example:
    [table findLatestRecordWithOrder:@"score ASC"]
 
 @param orderBy string for ORDER BY clause
 @param error error if fails
 @return query result (may be nil)
 */
- (id<BNCSQLiteRecordProtocol>)findLatestRecordWithOrder:(NSString *)orderBy
                                                   error:(NSError *__autoreleasing*)error;

#pragma mark - Query with single column equal condition

/**
 query record with primaryKey
 
 @param primaryKey primaryKey value
 @param error error if fails
 @return query result (may be nil)
 */
- (id<BNCSQLiteRecordProtocol>)findWithPrimaryKey:(NSNumber *)primaryKey
                                            error:(NSError *__autoreleasing*)error;


/**
 query all record with same column value

 @param column column name
 @param value column value
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithColumn:(NSString *)column
                                                        value:(id)value
                                                        error:(NSError *__autoreleasing*)error;

/**
 query all record with same column value and sorting by some rules

 @param column column name
 @param value column value
 @param orderBy sorting rules, string for ORDER BY clause, like @"price desc"
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithColumn:(NSString *)column
                                                        value:(id)value
                                                      orderBy:(NSString *)orderBy
                                                        error:(NSError *__autoreleasing*)error;

/**
 query all record that column value in `valueList`

 @param column column name
 @param valueList valueList
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithColumn:(NSString *)column
                                                  inValueList:(NSArray *)valueList
                                                        error:(NSError *__autoreleasing*)error;

/**
 query all record that column value in `valueList` and sorting by some rules

 @param column  column name
 @param valueList valueList
 @param orderBy sorting rules, string for ORDER BY clause, like @"price desc"
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithColumn:(NSString *)column
                                                  inValueList:(NSArray *)valueList
                                                      orderBy:(NSString *)orderBy
                                                        error:(NSError *__autoreleasing*)error;

/**
 query record that column value equal to `value` with limited
 
 if there is no limit, use `findAllWithColumn` replace

 @param column column name
 @param value column value
 @param limit limition , number for LIMIT clause. if limit is less than 1, the result will be same as `findAllWithColumn`
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithColumn:(NSString *)column
                                                           value:(id)value
                                                           limit:(NSUInteger)limit
                                                           error:(NSError *__autoreleasing*)error;

/**
 query record that column value equal to `value` with limited and sorting by some rules
 
 if there is no limit, use `findAllWithColumn` replace

 @param column column name
 @param value column value
 @param orderBy sorting rules, string for ORDER BY clause, like @"price desc"
 @param limit limition number for LIMIT clause. if limit is less than 1, the result will be same as `findAllWithColumn`
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithColumn:(NSString *)column
                                                           value:(id)value
                                                          orderBy:(NSString *)orderBy
                                                            limit:(NSUInteger)limit
                                                            error:(NSError *__autoreleasing*)error;


#pragma mark - Query without mulit column condition
/**
 query all record with where condition, but without orderby

 @see - (BOOL)deleteWithCondition:(NSString *)whereCondition
                           params:(NSDictionary *)conditionParams
                            error:(NSError *__autoreleasing*)error
 
 for how to use where condition.
 
 @param whereCondition the string for WHERE clause
 @param conditionParams the params to bind in to where condition
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithCondition:(NSString *)whereCondition
                                                          params:(NSDictionary *)conditionParams
                                                           error:(NSError *__autoreleasing*)error;

/**
 query all record with where condition with some sorting rules

 @see - (BOOL)deleteWithCondition:(NSString *)whereCondition
                           params:(NSDictionary *)conditionParams
                            error:(NSError *__autoreleasing*)error
 
 for how to use where condition.
 
 @param whereCondition string for WHERE clause
 @param conditionParams the params to bind in to where condition
 @param orderBy sorting rules, string for ORDER BY clause, like @"price desc"
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithCondition:(NSString *)whereCondition
                                                          params:(NSDictionary *)conditionParams
                                                         orderBy:(NSString *)orderBy
                                                           error:(NSError *__autoreleasing*)error;

/**
 query some record with where condition with limited

 @see - (BOOL)deleteWithCondition:(NSString *)whereCondition
                           params:(NSDictionary *)conditionParams
                            error:(NSError *__autoreleasing*)error
 
 for how to use where condition.
 
 @param whereCondition string for WHERE clause
 @param conditionParams the params to bind in to where condition
 @param limit limition, number for LIMIT clause. if limit is less than 1, the result will be same as `findAllWithCondition`
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithCondition:(NSString *)whereCondition
                                                          params:(NSDictionary *)conditionParams
                                                           limit:(NSUInteger)limit
                                                           error:(NSError *__autoreleasing*)error;

/**
 query some record with where condition with limited and sorting by some rules

 @see - (BOOL)deleteWithCondition:(NSString *)whereCondition
                           params:(NSDictionary *)conditionParams
                            error:(NSError *__autoreleasing*)error
 
 for how to use where condition.
 
 @param whereCondition string for WHERE clause
 @param conditionParams the params to bind in to where condition
 @param orderBy sorting rules, string for ORDER BY clause, like @"price desc"
 @param limit limition, number for LIMIT clause. if limit is less than 1, the result will be same as `findAllWithCondition`
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithCondition:(NSString *)whereCondition
                                                          params:(NSDictionary *)conditionParams
                                                         orderBy:(NSString *)orderBy
                                                           limit:(NSUInteger)limit
                                                           error:(NSError *__autoreleasing*)error;

#pragma mark - General Table Info Query

/**
 return the table record count

 @return the table record count
 */
- (NSUInteger)countTotalRecord;

/**
 return the table record count with where condition

 @see - (BOOL)deleteWithCondition:(NSString *)whereCondition
                           params:(NSDictionary *)conditionParams
                            error:(NSError *__autoreleasing*)error
 
 for how to use where condition.
 
 @param whereCondition string for WHERE clause
 @param whereConditionParams the params to bind in to where condition
 @return the table record count with where condition
 */
- (NSUInteger)countWithCondition:(NSString *)whereCondition
                          params:(NSDictionary *)whereConditionParams;

@end
