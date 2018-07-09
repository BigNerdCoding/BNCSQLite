//
//  BNCSQLiteTableColumnProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, BNCSQLiteTableColumnType) {
    BNCSQLiteTableColumnTypeInt,
    BNCSQLiteTableColumnTypeReal,
    BNCSQLiteTableColumnTypeText,
    BNCSQLiteTableColumnTypeBinary
};

@protocol BNCSQLiteTableColumnProtocol <NSObject>

@required
- (NSString *)columnName;

- (BNCSQLiteTableColumnType)columnType;

@optional
- (BOOL)isPrimarykey;

- (BOOL)isAutoIncrement;

- (BOOL)isUnique;

- (BOOL)isNotNull;

- (NSString*)defaultValue;

@end
