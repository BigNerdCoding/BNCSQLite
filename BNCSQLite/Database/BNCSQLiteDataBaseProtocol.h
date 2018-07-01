//
//  BNCDataBaseProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCDataBaseMigratorProtocol.h"

@protocol BNCDataBaseProtocol <NSObject>

@required
- (NSString *)databaseFilePath;

@optional
- (id<BNCDataBaseMigratorProtocol>)databaseMigrator;

@end
