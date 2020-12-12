//
//  BNCSQLiteDatabaseConfig.m
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/3.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteDatabaseConfig.h"
#import "BNCSQLiteDatabase.h"

@implementation BNCSQLiteDatabaseConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _filePath = @"";
        _latestSchemaVersion = kBNCSQLiteInitVersion;
        _isReadonly = NO;
        _isWALModeOn = NO;
        _migrationAction = nil;
    }
    
    return self;
}

@end
