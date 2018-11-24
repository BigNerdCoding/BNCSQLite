//
//  BNCSQLiteTestDatabaseV1.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTestDatabaseV1.h"

@implementation BNCSQLiteTestDatabaseV1

#pragma mark - BNCSQLiteDatabaseInfoProtocol
- (NSString *)databaseFilePath {
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"BNCSQLiteMigrationTest.sqlite"];
}

@end
