//
//  BNCSQLiteDatabase.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/6/29.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

/**
 specify the lock type when transaction begins

 use BNCSQLiteTransactionLockTypeDeferred if you are not sure which lock to use
 
 - BNCSQLiteTransactionLockTypeDeferred: perform BEGIN DEFERRED TRANSACTION, which uses SHARED lock
 - BNCSQLiteTransactionLockTypeImmediate: perform BEGIN IMMEDIATE TRANSACTION, which uses RESERVED lock.
 - BNCSQLiteTransactionLockTypeExclusive: perform BEGIN EXCLUSIVE TRANSACTION, which uses EXCLUSIVE lock.
 */

typedef NS_ENUM(NSUInteger, BNCSQLiteTransactionLockType){
    BNCSQLiteTransactionLockTypeDeferred,
    BNCSQLiteTransactionLockTypeImmediate,
    BNCSQLiteTransactionLockTypeExclusive,
};

@class BNCSQLiteDatabaseStatement,BNCSQLiteDatabaseConfig;

/**
 Block to perform bindings on statement

 @param statement instance of BNCSQLiteDatabaseStatement
 */
typedef void(^BindBlock)(BNCSQLiteDatabaseStatement *statement);

/**
 Callback of `sqlite3_step` to execute for each row

 @param statement instance of BNCSQLiteDatabaseStatement
 @param rowNum `sqlite3_step` rowNum   Warning: Not the primarykey id.
 */
typedef void(^RowHandleBlock)(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum);

// Error Domain
extern NSString * const kBNCSQLiteErrorDomain;

// Database InitVersion
extern NSInteger const kBNCSQLiteInitVersion;

@interface BNCSQLiteDatabase : NSObject

/**
*  The database used for SQLite library,'sqlite3' pointer
*/
@property (nonatomic, unsafe_unretained, readonly) sqlite3 *database;

/**
 Connect database with filepath

 @param config the config of the database
 
 @param error the error when create databse fails
 @return an instance of BNCDataBase
 */
- (instancetype)initWithConfig:(BNCSQLiteDatabaseConfig *)config error:(NSError *__autoreleasing *)error;

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
 Return the current schema version

 @return version of schema
 */
- (UInt64)currentVersion;

/**
 Update the schema version

 @param schemaVersion the new schema version
 */
- (void)updateSchemaVersion:(NSInteger)schemaVersion;

/**
 Executes a BEGIN, calls the provided closure and executes a ROLLBACK if an exception occurs or a COMMIT if no exception occurs.

 @param transaction Block to be executed inside transaction
 @param lockType the lock type of transaction, use BNCSQLiteTransactionLockTypeDeferred if you are not sure which lock to use
 
 @return NO if fails 
 */
- (BOOL)executeSQLWithTransaction:(BOOL (^)(void))transaction lockType:(BNCSQLiteTransactionLockType)lockType;

/**
 Execute the given sqlString

 @param sqlString the sql string to be executed
 @param bind Block to be executed for binding on each call
 @param rowHandle Block to be executed for each row
 @param error error if fails
 @return NO if fails
 */
- (BOOL)executeSQL:(NSString *)sqlString bind:(BindBlock)bind rowHandle:(RowHandleBlock)rowHandle error:(NSError *__autoreleasing *)error;

@end
