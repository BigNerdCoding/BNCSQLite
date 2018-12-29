//
//  BNCSQLiteDatabaseConfig.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
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
        _migrationAction = nil;
    }
    
    return self;
}

@end
