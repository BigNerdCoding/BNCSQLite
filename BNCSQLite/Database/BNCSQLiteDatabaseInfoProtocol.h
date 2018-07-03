//
//  BNCSQLiteDatabaseInfoProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteMigratorProtocol.h"

@protocol BNCSQLiteDatabaseInfoProtocol <NSObject>

@required
/**
 the path of database file. like /xxx/data/Library/test.sqlite

 @return the file path
 */
- (NSString *)databaseFilePath;

@optional

/**
 the database migrator

 @return an instance the comform `BNCSQLiteMigratorProtocol` prtocol
 */
- (id<BNCSQLiteMigratorProtocol>)databaseMigrator;

@end
