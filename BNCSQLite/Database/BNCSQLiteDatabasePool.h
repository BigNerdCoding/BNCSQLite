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

@interface BNCSQLiteDatabasePool : NSObject

+ (instancetype)sharedInstance;

- (BNCSQLiteDatabase *)databaseWithConfig:(BNCSQLiteDatabaseConfig *)config;

- (void)closeDatabase:(NSString *)filePath;

- (void)closeAllDatabase;

@end
