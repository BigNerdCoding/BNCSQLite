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

/**
 specify the checkpoint mode when checkpoint action run
 
 see detail at https://www.sqlite.org/c3ref/wal_checkpoint_v2.html

 - BNCSQLiteCheckpointModePassive: SQLITE_CHECKPOINT_PASSIVE
 - BNCSQLiteCheckpointModeFull: SQLITE_CHECKPOINT_FULL
 - BNCSQLiteCheckpointModeRestart: SQLITE_CHECKPOINT_RESTART
 - BNCSQLiteCheckpointModeTruncate: SQLITE_CHECKPOINT_TRUNCATE
 */
typedef NS_ENUM(NSUInteger, BNCSQLiteCheckpointMode) {
    BNCSQLiteCheckpointModePassive  = 0, // SQLITE_CHECKPOINT_PASSIVE,
    BNCSQLiteCheckpointModeFull     = 1, // SQLITE_CHECKPOINT_FULL,
    BNCSQLiteCheckpointModeRestart  = 2, // SQLITE_CHECKPOINT_RESTART,
    BNCSQLiteCheckpointModeTruncate = 3  // SQLITE_CHECKPOINT_TRUNCATE
};

NS_ASSUME_NONNULL_BEGIN

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
typedef void(^RowHandleBlock)(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum);

// Error Domain
static NSString * const kBNCSQLiteErrorDomain = @"kBNCSQLiteErrorDomain";

// Database InitVersion
static NSInteger const kBNCSQLiteInitVersion = 1;

@interface BNCSQLiteDatabase : NSObject

/**
*  The database used for SQLite library,'sqlite3' pointer
*/
@property (nonatomic, unsafe_unretained, readonly, nullable) sqlite3 *database;

/**
 Connect database with filepath

 @param config the config of the database
 
 @param error the error when create databse fails
 @return an instance of BNCDataBase
 */
- (instancetype)initWithConfig:(BNCSQLiteDatabaseConfig *)config error:(NSError *__nullable __autoreleasing *)error;

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
- (BOOL)executeSQL:(NSString *)sqlString bind:(BindBlock __nullable)bind rowHandle:(RowHandleBlock __nullable)rowHandle error:(NSError *__nullable __autoreleasing *)error;

/**
 Performs a WAL checkpoint

 @param checkpointMode checkpointMode The checkpoint mode for sqlite3_wal_checkpoint_v2
 @param error The NSError corresponding to the error, if any.
 @return YES on success, otherwise NO.
 */
- (BOOL)checkpoint:(BNCSQLiteCheckpointMode)checkpointMode error:(NSError * _Nullable *)error;

/**
 Performs a WAL checkpoint
 
 @param checkpointMode The checkpoint mode for sqlite3_wal_checkpoint_v2
 @param name The db name for sqlite3_wal_checkpoint_v2
 @param error The NSError corresponding to the error, if any.
 @return YES on success, otherwise NO.
 */
- (BOOL)checkpoint:(BNCSQLiteCheckpointMode)checkpointMode name:(NSString * _Nullable)name error:(NSError * _Nullable *)error;

/**
 Performs a WAL checkpoint
 
 @param checkpointMode The checkpoint mode for sqlite3_wal_checkpoint_v2
 @param name The db name for sqlite3_wal_checkpoint_v2
 @param error The NSError corresponding to the error, if any.
 @param logFrameCount If not NULL, then this is set to the total number of frames in the log file or to -1 if the checkpoint could not run because of an error or because the database is not in WAL mode.
 @param checkpointCount If not NULL, then this is set to the total number of checkpointed frames in the log file (including any that were already checkpointed before the function was called) or to -1 if the checkpoint could not run due to an error or because the database is not in WAL mode.
 @return YES on success, otherwise NO.
 */
- (BOOL)checkpoint:(BNCSQLiteCheckpointMode)checkpointMode name:(NSString * _Nullable)name logFrameCount:(int * _Nullable)logFrameCount checkpointCount:(int * _Nullable)checkpointCount error:(NSError * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END
