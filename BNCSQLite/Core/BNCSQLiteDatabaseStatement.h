//
//  BNCSQLiteDatabaseStatement.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/1.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class BNCSQLiteDatabase;

NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteDatabaseStatement : NSObject

/**
 *  A prepared statement object
 */
@property (nonatomic, unsafe_unretained, readonly, nullable) sqlite3_stmt *statement;

/**
 *  The database used for SQLite library,'sqlite3' pointer
 */
@property (nonatomic, unsafe_unretained, readonly, nullable) sqlite3 *database;

/**
 A wrapper a prepared statement object

 @param sqlString the sql string to be prepared
 @param database a BNCSQLiteDatabase instance
 @param error the error when prepared statement fails
 @return a BNCDataBaseStatement instance
 */
- (instancetype _Nullable)initWithSQLString:(NSString *)sqlString
                                   database:(BNCSQLiteDatabase *)database
                                      error:(NSError *__nullable __autoreleasing *)error;

/**
 Close the statement.
 */
- (void)finalizeStatement;

/**
 Evaluate An SQL Statement

 @return the result of `sqlite3_step`
 */
- (NSInteger)stepStatement;

/**
 Resets the SQL statement.
 
 @param error the error when reset statement fails
 
 @return NO if fails
 */
- (BOOL)resetStatementWithError:(NSError *__nullable __autoreleasing *)error;

/**
 Return the number of columns in mthe result set.

 @return Int count of columns in result set
 */
- (NSInteger)columnCount;

/**
 Returns the index for the named parameter.
 
 @param columnName String name of binding
 @return Int index of parameter
 */
- (int)queryBindParameterIndex:(NSString *)columnName;

@end

NS_ASSUME_NONNULL_END
