//
//  BNCSQLiteMigratorTest4.m
//  BNCSQLiteTests
//
//  Created by Jax Wu on 2018/7/10.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteMigratorTest4.h"
#import "BNCSQLiteMigrationTestStep2.h"
#import "BNCSQLiteMigrationTestStep3.h"
#import "BNCSQLiteMigrationTestStep4.h"

@implementation BNCSQLiteMigratorTest4

#pragma mark - BNCSQLiteMigratorProtocol
- (NSArray<NSNumber *> *)migrationVersionList {
    return @[@(kBNCSQLiteInitVersion),@(2),@(3),@(4)];
}

- (NSDictionary<NSNumber *,id<BNCSQLiteMigrationStepProtocol> > *)migrationStepDictionary {
    return @{@(2):[[BNCSQLiteMigrationTestStep2 alloc] init],
             @(3):[[BNCSQLiteMigrationTestStep3 alloc] init],
             @(4):[[BNCSQLiteMigrationTestStep4 alloc] init]};
}


@end
