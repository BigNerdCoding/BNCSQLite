//
//  BNCSQLiteTableColumn.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/2.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableColumnProtocol.h"

@interface BNCSQLiteTableColumn : NSObject <BNCSQLiteTableColumnProtocol>

/**
 Create a auto increment &  int primary column

 @param columnName primary column name
 @return a primary column instance
 */
+ (instancetype)initPrimaryColWithName:(NSString *)columnName;

/**
 Create an unique column

 @param columnName column name
 @param columnType column type
 @return an unique column instance
 */
+ (instancetype)initUniqueColWithName:(NSString *)columnName
                                  type:(BNCSQLiteTableColumnType)columnType;

/**
 Create a not null column

 @param columnName column name
 @param columnType column type
 @return a not null  instance
 */
+ (instancetype)initNotNullColWithName:(NSString *)columnName
                                  type:(BNCSQLiteTableColumnType)columnType;

/**
 Create a column

 @param columnName column name
 @param columnType column type
 @param constraint a callback that setting constraint
 @return a instance of BNCSQLiteTableColumn
 */
- (instancetype)initWithColName:(NSString *)columnName
                           type:(BNCSQLiteTableColumnType)columnType
                     constraint:(void(^)(BNCSQLiteTableColumn *column))constraint;

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
