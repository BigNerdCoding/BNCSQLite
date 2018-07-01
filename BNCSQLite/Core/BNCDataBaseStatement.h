//
//  BNCDataBaseStatement.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class BNCDataBase;

@interface BNCDataBaseStatement : NSObject

/**
 *  A prepared statement object
 */
@property (nonatomic, unsafe_unretained, readonly) sqlite3_stmt *statement;

/**
 *  The database used for SQLite library,'sqlite3' pointer
 */
@property (nonatomic, unsafe_unretained, readonly) sqlite3 *database;

/**
 A wrapper a prepared statement object

 @param sqlString the sql string to be prepared
 @param database a BNCDataBase instance
 @param error the error when prepared statement fails
 @return a BNCDataBaseStatement instance
 */
- (instancetype)initWithSQLString:(NSString *)sqlString
                         database:(BNCDataBase *)database
                            error:(NSError *__autoreleasing *)error;

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
- (BOOL)resetStatementWithError:(NSError *__autoreleasing *)error;

/**
 Return the number of columns in mthe result set.

 @return Int count of columns in result set
 */
- (NSInteger)columnCount;

@end
