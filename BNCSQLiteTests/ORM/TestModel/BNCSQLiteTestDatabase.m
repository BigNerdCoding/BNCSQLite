//
//  BNCSQLiteTestDatabase.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/2.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTestDatabase.h"

@implementation BNCSQLiteTestDatabase

#pragma mark - BNCSQLiteDatabaseInfoProtocol
- (NSString *)databaseFilePath {
    return kBNCSQLiteMemoryModePath;
}

@end


