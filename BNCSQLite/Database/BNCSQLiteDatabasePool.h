//
//  BNCSQLiteDatabasePool.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/1.
//  Copyright © 2018年 Jax Wu. All rights reserved.
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

#pragma mark - close database connect action

/**
 close the database in current thread by filePath

 @param filePath of the database
 */
- (void)closeDatabaseInCurrentThread:(NSString *)filePath;

/**
 close all database connection in current thread
 */
- (void)closeAllDatabaseInCurrentThread;

/**
 close the database using filePath

 this action may cause mulit thread illegal access
 
 @param filePath path of the database
 */
- (void)closeDatabase:(NSString *)filePath;

/**
 close all database connection
 
 this action may cause mulit thread illegal access 
 */
- (void)closeAllDatabase;

@end

NS_ASSUME_NONNULL_END
