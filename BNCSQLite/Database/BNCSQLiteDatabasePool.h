//
//  BNCSQLiteDatabasePool.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteDatabase.h"
#import "BNCSQLiteDatabaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteDatabasePool : NSObject

/**
 return the singleton instance

 @return return the singleton instance
 */
+ (instancetype)sharedInstance;

/**
 create database connect using config

 @param config database config
 @return a database connect
 */
- (BNCSQLiteDatabase *)databaseWithConfig:(BNCSQLiteDatabaseConfig *)config;

/**
 close the database in current thread by filePath

 @param filePath of the database
 */
- (void)closeDatabaseInCurrentThread:(NSString *)filePath;

/**
 close all database connection in current thread
 */
- (void)closeAllDatabaseInCurrentThread;

@end

NS_ASSUME_NONNULL_END
