//
//  BNCSQLiteTableColumn.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/2.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTableColumn.h"

@interface BNCSQLiteTableColumn()

@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) BNCSQLiteTableColumnType type;
@property(nonatomic, assign) BOOL primaryKey;
@property(nonatomic, assign) BOOL autoIncrement;
@property(nonatomic, assign) BOOL colNotNull;
@property(nonatomic, assign) BOOL uniqueColumn;
@property(nonatomic, strong) NSString   *colDefaultValue;

@end

@implementation BNCSQLiteTableColumn

+ (instancetype)primaryRowIDColWithName:(NSString *)columnName {
    return [[BNCSQLiteTableColumn alloc] initWithColName:columnName type:BNCSQLiteTableColumnTypeInt constraint:^(BNCSQLiteTableColumn *column) {
        [column settingPrimarykeyConstraint];
        [column settingAutoIncrementConstraint];
    }];
}

+ (instancetype)uniqueColWithName:(NSString *)columnName
                             type:(BNCSQLiteTableColumnType)columnType {
    
    return [[BNCSQLiteTableColumn alloc] initWithColName:columnName type:columnType constraint:^(BNCSQLiteTableColumn *column) {
        [column settingUniqueConstraint];
    }];
}

+ (instancetype)notNullColWithName:(NSString *)columnName
                              type:(BNCSQLiteTableColumnType)columnType {
    return [[BNCSQLiteTableColumn alloc] initWithColName:columnName type:columnType constraint:^(BNCSQLiteTableColumn *column) {
        [column settingNotNullConstraint];
    }];
}

+ (instancetype)uniqueNotNullColWithName:(NSString *)columnName
                                    type:(BNCSQLiteTableColumnType)columnType {
    return [[BNCSQLiteTableColumn alloc] initWithColName:columnName type:columnType constraint:^(BNCSQLiteTableColumn *column) {
        [column settingUniqueConstraint];
        [column settingNotNullConstraint];
    }];
}

+ (instancetype)intColWithName:(NSString *)columnName {
    return [BNCSQLiteTableColumn intColWithName:columnName constraint:nil];
}

+ (instancetype)intColWithName:(NSString *)columnName constraint:(void(^)(BNCSQLiteTableColumn *column))constraint {
    return [[BNCSQLiteTableColumn alloc] initWithColName:columnName type:BNCSQLiteTableColumnTypeInt constraint:constraint];
}

+ (instancetype)realColWithName:(NSString *)columnName {
    return [BNCSQLiteTableColumn realColWithName:columnName constraint:nil];
}

+ (instancetype)realColWithName:(NSString *)columnName constraint:(void(^)(BNCSQLiteTableColumn *column))constraint {
    return [[BNCSQLiteTableColumn alloc] initWithColName:columnName type:BNCSQLiteTableColumnTypeReal constraint:constraint];
}

+ (instancetype)textColWithName:(NSString *)columnName {
    return [BNCSQLiteTableColumn textColWithName:columnName constraint:nil];
}

+ (instancetype)textColWithName:(NSString *)columnName constraint:(void(^)(BNCSQLiteTableColumn *column))constraint {
    return [[BNCSQLiteTableColumn alloc] initWithColName:columnName type:BNCSQLiteTableColumnTypeText constraint:constraint];
}

+ (instancetype)binaryColWithName:(NSString *)columnName {
    return [BNCSQLiteTableColumn binaryColWithName:columnName constraint:nil];
}

+ (instancetype)binaryColWithName:(NSString *)columnName constraint:(void(^)(BNCSQLiteTableColumn *column))constraint {
    return [[BNCSQLiteTableColumn alloc] initWithColName:columnName type:BNCSQLiteTableColumnTypeBinary constraint:constraint];
}

- (instancetype)initWithColName:(NSString *)columnName type:(BNCSQLiteTableColumnType)columnType constraint:(void(^)(BNCSQLiteTableColumn *column))constraint;{
    self = [super init];
    if (self) {
        _name = columnName;
        _type = columnType;
        _primaryKey = NO;
        _autoIncrement = NO;
        _uniqueColumn  = NO;
        _colNotNull = NO;
        if (constraint) {
            constraint(self);
        }
    }
    
    return self;
}

- (void)settingPrimarykeyConstraint {
    self.primaryKey = YES;
}

- (void)settingAutoIncrementConstraint {
    self.autoIncrement = YES;
}

- (void)settingUniqueConstraint {
    self.uniqueColumn = YES;
}

- (void)settingNotNullConstraint {
    self.colNotNull = YES;
}

- (void)settingDefaultValueConstraint:(NSString *)defaultValue {
    self.colDefaultValue = defaultValue;
}

#pragma mark -  BNCSQLiteTableColumnProtocol
- (NSString *)columnName {
    return _name;
}

- (BNCSQLiteTableColumnType)columnType {
    return _type;
}

- (BOOL)isPrimarykey {
    return _primaryKey;
}

- (BOOL)isAutoIncrement {
    return _autoIncrement;
}

- (BOOL)isUnique; {
    return _uniqueColumn;
}

- (BOOL)isNotNull {
    return _colNotNull;
}

- (NSString *)defaultValue {
    return _colDefaultValue;
}

@end


