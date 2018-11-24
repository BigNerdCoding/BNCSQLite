//
//  BNCSQLiteTestDatabaseV3.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTestDatabaseV3.h"
#import "BNCSQLiteMigratorTest3.h"

@implementation BNCSQLiteTestDatabaseV3

#pragma mark - BNCSQLiteDatabaseInfoProtocol
- (NSString *)databaseFilePath {
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"BNCSQLiteMigrationTest.sqlite"];
}

- (id<BNCSQLiteMigratorProtocol>)databaseMigrator {
    return [[BNCSQLiteMigratorTest3 alloc] init];
}

@end
