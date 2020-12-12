//
//  BNCSQLiteDatabaseInfoProtocol.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/1.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteMigratorProtocol.h"

NS_ASSUME_NONNULL_BEGIN
// Database Mode
static NSString * const kBNCSQLiteMemoryModePath = @":memory:";
static NSString * const kBNCSQLiteTemporaryModePath = @"";

@protocol BNCSQLiteDatabaseInfoProtocol <NSObject>

@required

/**
 the path of database file. like /xxx/data/Library/test.sqlite
 
 when you need memory mode return kBNCSQLiteMemoryModePath
 when you need temporara mode return kBNCSQLiteTemporaryModePath
 
 @return the file path
 */
- (NSString *)databaseFilePath;

@optional

/**
 the database migrator

 @return an instance the comform `BNCSQLiteMigratorProtocol` prtocol
 */
- (id<BNCSQLiteMigratorProtocol>)databaseMigrator;

/**
 whether the database is readobly

 @return whether the database is readobly
 */
- (BOOL)isReadonly;

/**
 whether the database activate wal mode unless readonly
 
 @return whether the database wal mode is activate
 */
- (BOOL)isWALModeOn;

@end

NS_ASSUME_NONNULL_END
