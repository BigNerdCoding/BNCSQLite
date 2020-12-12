//
//  BNCSQLiteTableColumnProtocol.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/1.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
SQLite column type

 - BNCSQLiteTableColumnTypeInt: Int Type
 - BNCSQLiteTableColumnTypeReal: Real Type
 - BNCSQLiteTableColumnTypeText: Text Type
 - BNCSQLiteTableColumnTypeBinary: Blob Type
 */
typedef NS_ENUM (NSUInteger, BNCSQLiteTableColumnType) {
    BNCSQLiteTableColumnTypeInt,
    BNCSQLiteTableColumnTypeReal,
    BNCSQLiteTableColumnTypeText,
    BNCSQLiteTableColumnTypeBinary
};

NS_ASSUME_NONNULL_BEGIN

@protocol BNCSQLiteTableColumnProtocol <NSObject>

@required

/**
 column name

 @return column name
 */
- (NSString *)columnName;

/**
 column type

 @return column
 */
- (BNCSQLiteTableColumnType)columnType;

@optional

/**
 whether the column is primary key

 @return whether the column is primary key
 */
- (BOOL)isPrimarykey;

/**
 whether the column is autoIncrement

 @return whether the column is autoIncrement
 */
- (BOOL)isAutoIncrement;

/**
 whether the column is unique

 @return whether the column is unique
 */
- (BOOL)isUnique;

/**
 whether the column is not null

 @return whether the column is not null
 */
- (BOOL)isNotNull;

/**
 column default value

 @return column default value
 */
- (NSString*)defaultValue;

@end

NS_ASSUME_NONNULL_END
