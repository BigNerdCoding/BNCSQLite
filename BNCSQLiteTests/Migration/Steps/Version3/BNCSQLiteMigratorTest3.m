//
//  BNCSQLiteMigratorTest3.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteMigratorTest3.h"
#import "BNCSQLiteMigrationTestStep2.h"
#import "BNCSQLiteMigrationTestStep3.h"

@implementation BNCSQLiteMigratorTest3

#pragma mark - BNCSQLiteMigratorProtocol
- (NSArray<NSNumber *> *)migrationVersionList {
    return @[@(kBNCSQLiteInitVersion),@(2),@(3)];
}

- (NSDictionary<NSNumber *,id<BNCSQLiteMigrationStepProtocol> > *)migrationStepDictionary {
    return @{@(2):[[BNCSQLiteMigrationTestStep2 alloc] init],
             @(3):[[BNCSQLiteMigrationTestStep3 alloc] init]};
}


@end
