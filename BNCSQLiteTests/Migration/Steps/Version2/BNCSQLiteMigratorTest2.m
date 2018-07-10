//
//  BNCSQLiteMigratorTest2.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteMigratorTest2.h"
#import "BNCSQLiteMigrationTestStep2.h"

@implementation BNCSQLiteMigratorTest2

#pragma mark - BNCSQLiteMigratorProtocol
- (NSArray<NSNumber *> *)migrationVersionList {
    return @[@(kBNCSQLiteInitVersion),@(2)];
}

- (NSDictionary<NSNumber *,id<BNCSQLiteMigrationStepProtocol> > *)migrationStepDictionary {
    return @{@(2):[[BNCSQLiteMigrationTestStep2 alloc] init]};
}

@end
