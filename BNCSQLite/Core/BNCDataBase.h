//
//  BNCDataBase.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/6/29.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class BNCDataBaseStatement;

typedef void(^BindBlock)(BNCDataBaseStatement *statement);
typedef void(^RowHandleBlock)(BNCDataBaseStatement *statement, uint64_t rowID);

extern NSString * const kBNCSQLiteErrorDomain;



@interface BNCDataBase : NSObject

/**
*  The database used for SQLite library,'sqlite3' pointer
*/
@property (nonatomic, unsafe_unretained, readonly) sqlite3 *database;

/**
 Connect database with filepath

 @param filePath the filepath of the database
 @param error the error when create databse fails
 @return an instance of BNCDataBase
 */
- (instancetype)initWithPath:(NSString *)filePath error:(NSError *__autoreleasing *)error;

/**
 Close the database connection
 */
- (void)closeDatabase;

/**
 Return the value of `sqlite3_last_insert_rowid`.

 @return Int last inserted row ID
 */
- (UInt64)latestInsertRowID;

/**
 Returns the value of `sqlite3_changes`.

 @return Int number of changes
 */
- (UInt64)changes;

/**
 Returns the value of `sqlite3_total_changes`.

 @return Int total changes
 */
- (UInt64)totalChanges;

/**
 Executes a BEGIN, calls the provided closure and executes a ROLLBACK if an exception occurs or a COMMIT if no exception occurs.

 @param transaction Block to be executed inside transaction
 */
- (void)executeSQLWithTransaction:(void(^)(void))transaction;

/**
 Execute the given sql statement

 @param sqlString the sql string to be executed
 @param bind Block to be executed for binding on each call
 @param rowHandle Block to be executed for each row
 @param error error if fails
 @return NO if fails
 */
- (BOOL)executeSQL:(NSString *)sqlString bind:(BindBlock)bind rowHandle:(RowHandleBlock)rowHandle error:(NSError *__autoreleasing *)error;

@end
