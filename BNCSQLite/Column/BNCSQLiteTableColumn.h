//
//  BNCSQLiteTableColumn.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/2.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableColumnProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@class BNCSQLiteTableColumn;

/**
 Block to perform column  constraint setting
 
 @param column instance of BNCSQLiteTableColumn
 */
typedef void(^ColumnConstraintBlock)(BNCSQLiteTableColumn *column);



@interface BNCSQLiteTableColumn : NSObject <BNCSQLiteTableColumnProtocol>

/**
 Create a auto increment &  int primary column
 
 @param columnName primary column name
 @return a primary column instance
 */
+ (instancetype)primaryRowIDColWithName:(NSString *)columnName;

/**
 Create an unique column
 
 @param columnName column name
 @param columnType column type
 @return an unique column instance
 */
+ (instancetype)uniqueColWithName:(NSString *)columnName
                             type:(BNCSQLiteTableColumnType)columnType;

/**
 Create a not null column
 
 @param columnName column name
 @param columnType column type
 @return a not null  instance
 */
+ (instancetype)notNullColWithName:(NSString *)columnName
                              type:(BNCSQLiteTableColumnType)columnType;

/**
 Create an unique and not null column
 
 @param columnName column name
 @param columnType column type
 @return an unique and not null column
 */
+ (instancetype)uniqueNotNullColWithName:(NSString *)columnName
                                    type:(BNCSQLiteTableColumnType)columnType;

/**
 Crate integer type column
 
 @param columnName column name
 @return integer type column
 */
+ (instancetype)intColWithName:(NSString *)columnName;

/**
 Crate integer type column
 
 @param columnName column name
 @param constraint a callback that setting constraint
 @return integer type column
 */
+ (instancetype)intColWithName:(NSString *)columnName constraint:(ColumnConstraintBlock __nullable)constraint;

/**
 Crate real type column
 
 @param columnName column name
 @return real type column
 */
+ (instancetype)realColWithName:(NSString *)columnName;

/**
 Crate real type column
 
 @param columnName column name
 @param constraint a callback that setting constraint
 @return real type column
 */
+ (instancetype)realColWithName:(NSString *)columnName constraint:(ColumnConstraintBlock __nullable)constraint;

/**
 Crate text type column
 
 @param columnName column name
 @return text type column
 */
+ (instancetype)textColWithName:(NSString *)columnName;

/**
 Crate text type column
 
 @param columnName column name
 @param constraint  a callback that setting constraint
 @return text type column
 */
+ (instancetype)textColWithName:(NSString *)columnName constraint:(ColumnConstraintBlock __nullable)constraint;

/**
 Create binary type column
 
 @param columnName column name
 @return binary type column
 */
+ (instancetype)binaryColWithName:(NSString *)columnName;

/**
 crate binary type column
 
 @param columnName column name
 @param constraint a callback that setting constraint
 @return binary type column
 */
+ (instancetype)binaryColWithName:(NSString *)columnName constraint:(ColumnConstraintBlock __nullable)constraint;

/**
 Create a column
 
 @param columnName column name
 @param columnType column type
 @param constraint a callback that setting constraint
 @return a instance of BNCSQLiteTableColumn
 */
- (instancetype)initWithColName:(NSString *)columnName
                           type:(BNCSQLiteTableColumnType)columnType
                     constraint:(ColumnConstraintBlock __nullable)constraint;

/**
 setting the column to be primary column
 */
- (void)settingPrimarykeyConstraint;

/**
 setting the column to be auto increment
 */
- (void)settingAutoIncrementConstraint;

/**
 setting the column to be unique
 */
- (void)settingUniqueConstraint;

/**
 setting the column to be not null
 */
- (void)settingNotNullConstraint;

/**
 setting the column default value
 
 @param defaultValue default value of the column
 */
- (void)settingDefaultValueConstraint:(NSString *)defaultValue;

@end

NS_ASSUME_NONNULL_END

