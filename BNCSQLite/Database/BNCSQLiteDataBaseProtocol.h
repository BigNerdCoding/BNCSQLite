//
//  BNCSQLiteDataBaseProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteMigratorProtocol.h"

@protocol BNCSQLiteDataBaseProtocol <NSObject>

@required
- (NSString *)databaseFilePath;

@optional
- (id<BNCSQLiteMigratorProtocol>)databaseMigrator;

@end
