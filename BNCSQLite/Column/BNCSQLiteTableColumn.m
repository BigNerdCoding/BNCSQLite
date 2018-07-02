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
@property(nonatomic, assign) BOOL colNull;
@property(nonatomic, strong) NSString *colDefaultValue;

@end

@implementation BNCSQLiteTableColumn

+ (instancetype)initRowIDColWithName:(NSString *)columnName {
    BNCSQLiteTableColumn *column = [[BNCSQLiteTableColumn alloc] initWithColName:columnName type:BNCSQLiteTableColumnTypeInt constraint:^(BNCSQLiteTableColumn *column) {
        [column settingPrimarykeyConstraint];
        [column settingAutoIncrementConstraint];
    }];
    
    return column;
}

+ (instancetype)initNotNullColWithName:(NSString *)columnName
                                  type:(BNCSQLiteTableColumnType)columnType {
    BNCSQLiteTableColumn *column = [[BNCSQLiteTableColumn alloc] initWithColName:columnName type:columnType constraint:^(BNCSQLiteTableColumn *column) {
        [column settingNotNullConstraint];
    }];
    
    return column;
}

- (instancetype)initWithColName:(NSString *)columnName type:(BNCSQLiteTableColumnType)columnType constraint:(void(^)(BNCSQLiteTableColumn *column))constraint;{
    self = [super init];
    if (self) {
        _name = columnName;
        _type = columnType;
        _primaryKey = NO;
        _autoIncrement = NO;
        _colDefaultValue = @"";
        
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

- (void)settingNotNullConstraint {
    self.colNull = NO;
}

- (void)settingDefaultValueConstraint:(NSString *)defaultValue {
    self.colDefaultValue   = defaultValue;
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

- (BOOL)isNull {
    return _colNull;
}

- (NSString *)defaultValue {
    return _colDefaultValue;
}

@end
