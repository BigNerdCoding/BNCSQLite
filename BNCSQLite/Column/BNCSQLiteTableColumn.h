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

+ (instancetype)initRowIDColWithName:(NSString *)columnName;

+ (instancetype)initUniqueColWithName:(NSString *)columnName
                                  type:(BNCSQLiteTableColumnType)columnType;

+ (instancetype)initNotNullColWithName:(NSString *)columnName
                                  type:(BNCSQLiteTableColumnType)columnType;

- (instancetype)initWithColName:(NSString *)columnName
                           type:(BNCSQLiteTableColumnType)columnType
                     constraint:(void(^)(BNCSQLiteTableColumn *column))constraint;

- (void)settingPrimarykeyConstraint;

- (void)settingAutoIncrementConstraint;

- (void)settingUniqueConstraint;

- (void)settingNotNullConstraint;

- (void)settingDefaultValueConstraint:(NSString *)defaultValue;

@end
