//
//  BNCSQLiteDatabaseConfig.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/3.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNCSQLiteDatabase;

NS_ASSUME_NONNULL_BEGIN

/**
 the migration block

 @param dbConnect database connect 
 */
typedef void (^MigrationBlock)(BNCSQLiteDatabase *dbConnect);

@interface BNCSQLiteDatabaseConfig : NSObject

/**
 Database filePath
 */
@property(nonatomic, copy) NSString *filePath;

/**
 latest schemaVersion default: kBNCSQLiteInitVersion
 */
@property(nonatomic, assign) NSInteger latestSchemaVersion;

/**
 whether the database is readobly
 */
@property(nonatomic, assign) BOOL isReadonly;

/**
 whether the database activate wal mode unless readonly
 */
@property(nonatomic, assign) BOOL isWALModeOn;

/**
 Block that do migration action
 */
@property(nonatomic, copy, nullable) MigrationBlock migrationAction;
 
@end

NS_ASSUME_NONNULL_END
