//
//  BNCSQLiteDatabaseConfig.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNCSQLiteDatabase;

typedef void (^MigrationBlock)(BNCSQLiteDatabase *dbConnect);

@interface BNCSQLiteDatabaseConfig : NSObject
/**
 Database filePath
 */
@property(nonatomic, strong) NSString *filePath;

/**
 latest schemaVersion default: kBNCSQLiteInitVersion
 */
@property(nonatomic, strong) NSString *latestSchemaVersion;

/**
 Block that do migration action
 */
@property(nonatomic, strong) MigrationBlock migrationAction;

@end
