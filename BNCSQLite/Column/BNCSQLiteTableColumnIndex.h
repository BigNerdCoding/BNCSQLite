//
//  BNCSQLiteTableColumnIndex.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableColumnIndexProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteTableColumnIndex : NSObject <BNCSQLiteTableColumnIndexProtocol>

/**
 create a common index

 @param indexName index name
 @param fileds indexed column list name
 @return an instance of BNCSQLiteTableColumnIndex
 */
- (instancetype)initWithIndexName:(NSString *)indexName fields:(NSArray<NSString *> *)fileds;

/**
 create a unique index

 @param indexName index name
 @param fields indexed column list name
 @return an instance of BNCSQLiteTableColumnIndex
 */
- (instancetype)initWithUniqueIndexName:(NSString *)indexName fields:(NSArray<NSString *> *)fields;

@end

NS_ASSUME_NONNULL_END
