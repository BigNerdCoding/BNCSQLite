//
//  BNCSQLiteTestDatabaseV2.m
//  BNCSQLiteTests
//
//  Created by Jax Wu on 2018/7/10.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteTestDatabaseV2.h"
#import "BNCSQLiteMigratorTest2.h"

@implementation BNCSQLiteTestDatabaseV2

#pragma mark - BNCSQLiteDatabaseInfoProtocol
- (NSString *)databaseFilePath {
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"BNCSQLiteMigrationTest.sqlite"];
}

- (id<BNCSQLiteMigratorProtocol>)databaseMigrator {
    return [[BNCSQLiteMigratorTest2 alloc] init];
}

@end
