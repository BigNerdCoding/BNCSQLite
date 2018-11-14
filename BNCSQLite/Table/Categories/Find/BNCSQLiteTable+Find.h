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
 query record with limit
 
 @param limit string for LIMIT clause, if limit is less than 1, the result will be same as `findAllWithError`
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithLimit:(NSUInteger)limit
                                                          error:(NSError *__autoreleasing*)error;

/**
 query record with order and limit
 
 @param orderBy string for ORDER BY clause
 @param limit string for LIMIT clause if limit is less than 1, the result will be same as `findAllWithOrder`
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithOrder:(NSString *)orderBy
                                                          limit:(NSUInteger)limit
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
 query record with unique column
 
 @param columuName column name
 @param value column value
 @param error error if fails
 @return query result (may be nil)
 */
- (id<BNCSQLiteRecordProtocol>)findWithUniqueColumn:(NSString *)columuName
                                              value:(id)value
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

/**
 query all record with same column value like 'xxxx'
 
 @param column column name
 @param like like Clause
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithColumn:(NSString *)column
                                                   likeClause:(NSString *)like
                                                        error:(NSError *__autoreleasing*)error;

/**
 query all record with same column value like 'xxxx'
 
 @param column column name
 @param like like Clause
 @param orderBy sorting rules, string for ORDER BY clause, like @"price desc"
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithColumn:(NSString *)column
                                                   likeClause:(NSString *)like
                                                      orderBy:(NSString *)orderBy
                                                        error:(NSError *__autoreleasing*)error;

/**
 query record with same column value like 'xxxx'
 
 @param column column name
 @param like like Clause
 @param limit limition number for LIMIT clause. if limit is less than 1, the result will be same as `findAllWithColumn`
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithColumn:(NSString *)column
                                                      likeClause:(NSString *)like
                                                           limit:(NSUInteger)limit
                                                           error:(NSError *__autoreleasing*)error;

/**
 query record with same column value like 'xxxx'
 
 if there is no limit, use `findAllWithColumn` replace
 
 @param column column name
 @param like like Clause
 @param orderBy sorting rules, string for ORDER BY clause, like @"price desc"
 @param limit limition number for LIMIT clause. if limit is less than 1, the result will be same as `findAllWithColumn`
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithColumn:(NSString *)column
                                                      likeClause:(NSString *)like
                                                         orderBy:(NSString *)orderBy
                                                           limit:(NSUInteger)limit
                                                           error:(NSError *__autoreleasing*)error;

#pragma mark - Query with mulit column condition
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
 query all record with where condition and some sorting rules
 
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

#pragma mark - Query with Ready whereCondition

/**
 query all record with where condition
 
 @param whereCondition string for WHERE clause like   @"age > 18" 、@" age > 18 AND height > 170"
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithWhere:(NSString *)whereCondition
                                                       error:(NSError *__autoreleasing*)error;

/**
 query all record with where condition and sorting by some rules
 
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 @param orderBy sorting rules, string for ORDER BY clause, like @"price desc"
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithWhere:(NSString *)whereCondition
                                                     orderBy:(NSString *)orderBy
                                                       error:(NSError *__autoreleasing*)error;

/**
 query some record with where condition and limition
 
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 @param limit limition, number for LIMIT clause. if limit is less than 1, the result will be same as `findAllWithCondition`
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithWhere:(NSString *)whereCondition
                                                          limit:(NSUInteger)limit
                                                          error:(NSError *__autoreleasing*)error;

/**
 query some record with where condition and sorting by some rules
 
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 @param orderBy sorting rules, string for ORDER BY clause, like @"price desc"
 @param limit limition, number for LIMIT clause. if limit is less than 1, the result will be same as `findAllWithCondition`
 @param error error if fails
 @return query result
 */
- (NSArray <id<BNCSQLiteRecordProtocol> > *)findRecordWithWhere:(NSString *)whereCondition
                                                        orderBy:(NSString *)orderBy
                                                          limit:(NSUInteger)limit
                                                          error:(NSError *__autoreleasing*)error;

@end

