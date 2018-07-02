//
//  BNCSQLiteDatabasePool.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteDataBase.h"

@interface BNCSQLiteDatabasePool : NSObject

+ (instancetype)sharedInstance;

- (BNCSQLiteDataBase *)databaseWith:(NSString *)filePath;

- (void)closeDatabase:(NSString *)filePath;

- (void)closeAllDatabase;

@end
