//
//  BNCSQLiteTableColumnIndexProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BNCSQLiteTableColumnIndexProtocol <NSObject>

@required

/**
 whether an unique index

 @return whether an unique index
 */
- (BOOL)isUniqueIndex;

/**
 index name

 @return index name
 */
- (NSString *)indexName;

/**
 indexed column list name

 @return column list name
 */
- (NSArray<NSString *> *)indexCloumnFields;

@end

NS_ASSUME_NONNULL_END
