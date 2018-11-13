//
//  BNCSQLiteTestDatabaseV2.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTestDatabaseV2.h"
#import "BNCSQLiteMigratorTest2.h"

@implementation BNCSQLiteTestDatabaseV2

#pragma mark - BNCSQLiteDatabaseInfoProtocol
- (NSString *)databaseFilePath {
    return kBNCSQLiteMemoryModePath;
}

- (id<BNCSQLiteMigratorProtocol>)databaseMigrator {
    return [[BNCSQLiteMigratorTest2 alloc] init];
}

@end
