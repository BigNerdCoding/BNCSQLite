//
//  BNCSQLiteTestDatabaseV4.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTestDatabaseV4.h"
#import "BNCSQLiteMigratorTest4.h"

@implementation BNCSQLiteTestDatabaseV4

#pragma mark - BNCSQLiteDatabaseInfoProtocol
- (NSString *)databaseFilePath {
    return kBNCSQLiteMemoryModePath;
    
}

- (id<BNCSQLiteMigratorProtocol>)databaseMigrator {
    return [[BNCSQLiteMigratorTest4 alloc] init];
}

@end
