//
//  BNCSQLiteTableColumnIndex.m
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/3.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteTableColumnIndex.h"

@interface BNCSQLiteTableColumnIndex()

@property(nonatomic, assign) BOOL isUnique;
@property(nonatomic, strong) NSString *nameOfIndex;
@property(nonatomic, strong) NSArray *fields;

@end

@implementation BNCSQLiteTableColumnIndex

- (instancetype)init {
    self = [super init];
    if (self) {
        _isUnique = NO;
        _nameOfIndex = @"";
        _fields = @[];
    }
    
    return self;
}
- (instancetype)initWithIndexName:(NSString *)indexName fields:(NSArray<NSString *> *)fileds {
    self = [super init];
    if (self) {
        _isUnique = NO;
        _nameOfIndex = indexName;
        _fields = fileds;
    }
    
    return self;
}

- (instancetype)initWithUniqueIndexName:(NSString *)indexName fields:(NSArray<NSString *> *)fields {
    self = [super init];
    
    if (self) {
        _isUnique = YES;
        _nameOfIndex = indexName;
        _fields = fields;
    }
    
    return self;
}

#pragma mark - BNCSQLiteTableColumnIndex
- (NSArray<NSString *> *)indexCloumnFields {
    
    if (!self.fields) {
        return @[];
    }
    return self.fields;
}

- (NSString *)indexName {
    return self.nameOfIndex;
}

- (BOOL)isUniqueIndex {
    return self.isUnique;
}

@end
