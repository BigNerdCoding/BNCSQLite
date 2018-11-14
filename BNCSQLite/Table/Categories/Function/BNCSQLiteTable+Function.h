//
//  BNCSQLiteTable+Function.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/11/14.
//  Copyright © 2018 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable.h"

@interface BNCSQLiteTable (Function)

#pragma mark - count function
/**
 return the table record count
 
 @return the table record count
 */
- (UInt64)countTotalRecord;

/**
 return the table record count with where condition
 
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 @return the table record count
 */
- (UInt64)countWithCondition:(NSString *)whereCondition;

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
- (UInt64)countWithCondition:(NSString *)whereCondition
                      params:(NSDictionary *)whereConditionParams;

#pragma mark - max function
/**
 return column max int value
 
 @param column column name
 @return the max int value
 */
- (UInt64)maxIntValueOfColumn:(NSString *)column;

/**
 return column max int value
 
 @param column column name
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 @return the max int value
 */
- (UInt64)maxIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition;

/**
 return column max int value
 
 @param column column name
 @param whereCondition string for WHERE clause
 @param whereConditionParams the params to bind in to where condition
 @return the max int value
 */
- (UInt64)maxIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition
                       params:(NSDictionary *)whereConditionParams;

/**
 return column max double value
 
 @param column column name
 @return the max double value
 */
- (double)maxDoubleValueOfColumn:(NSString *)column;

/**
 return column max double value
 
 @param column column name
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 @return the max double value
 */
- (double)maxDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition;

/**
 return column max double value
 
 @param column column name
 @param whereCondition string for WHERE clause
 @param whereConditionParams the params to bind in to where condition
 @return the max double value
 */
- (double)maxDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition
                          params:(NSDictionary *)whereConditionParams;

#pragma mark - min function
/**
 return column min int value
 
 @param column column name
 @return the min int value
 */
- (UInt64)minIntValueOfColumn:(NSString *)column;

/**
 return column min int value
 
 @param column column name
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 @return the min int value
 */
- (UInt64)minIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition;

/**
 return column min int value
 
 @param column column name
 @param whereCondition string for WHERE clause
 @param whereConditionParams the params to bind in to where condition
 @return the min int value
 */
- (UInt64)minIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition
                       params:(NSDictionary *)whereConditionParams;

/**
 return column min double value
 
 @param column column name
 @return the max int value
 */
- (double)minDoubleValueOfColumn:(NSString *)column;

/**
 return column max double value
 
 @param column column name
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 @return the max double value
 */
- (double)minDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition;

/**
 return column max double value
 
 @param column column name
 @param whereCondition string for WHERE clause
 @param whereConditionParams the params to bind in to where condition
 @return the max double value
 */
- (double)minDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition
                          params:(NSDictionary *)whereConditionParams;

#pragma mark - sum function
/**
 return int column value sum
 
 @param column column name
 @return int column value sum
 */
- (UInt64)sumIntValueOfColumn:(NSString *)column;

/**
 return int column value sum
 
 @param column column name
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 @return int column value sum
 */
- (UInt64)sumIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition;

/**
 return int column value sum
 
 @param column column name
 @param whereCondition string for WHERE clause
 @param whereConditionParams the params to bind in to where condition
 @return int column value sum
 */
- (UInt64)sumIntValueOfColumn:(NSString *)column
                        where:(NSString *)whereCondition
                       params:(NSDictionary *)whereConditionParams;

/**
 return double column value sum
 
 @param column column name
 @return double column value sum
 */
- (double)sumDoubleValueOfColumn:(NSString *)column;

/**
 return double column value sum
 
 @param column column name
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 @return double column value sum
 */
- (double)sumDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition;

/**
 return double column value sum
 
 @param column column name
 @param whereCondition string for WHERE clause
 @param whereConditionParams the params to bind in to where condition
 @return double column value sum
 */
- (double)sumDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition
                          params:(NSDictionary *)whereConditionParams;

#pragma mark - avg function
/**
 return column avg value
 
 @param column column name
 return column avg value
 */
- (double)avgDoubleValueOfColumn:(NSString *)column;

/**
 return column avg value
 
 @param column column name
 @param whereCondition string for WHERE clause like  @"age > 18" 、@" age > 18 AND height > 170"
 return column avg value
 */
- (double)avgDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition;

/**
 return column avg value
 
 @param column column name
 @param whereCondition string for WHERE clause
 @param whereConditionParams the params to bind in to where condition
 return column avg value
 */
- (double)avgDoubleValueOfColumn:(NSString *)column
                           where:(NSString *)whereCondition
                          params:(NSDictionary *)whereConditionParams;

@end

