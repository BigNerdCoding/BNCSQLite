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

@property(nonatomic, strong) NSString *filePath;
@property(nonatomic, strong) NSString *latestSchemaVersion;
@property(nonatomic, strong) MigrationBlock migrationAction;

@end
