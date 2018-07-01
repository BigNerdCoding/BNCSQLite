//
//  BNCSQLiteDatabasePool.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCDataBase.h"

@interface BNCSQLiteDatabasePool : NSObject

- (instancetype)sharedInstance;

- (BNCDataBase *)databaseWith:(NSString *)filePath;

- (void)closeDatabase:(NSString *)filePath;

- (void)closeAllDatabase;

@end
