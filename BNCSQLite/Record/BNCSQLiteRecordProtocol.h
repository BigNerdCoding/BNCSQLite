//
//  BNCSQLiteRecordProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BNCSQLiteRecordProtocol <NSObject>

@required

/**
 transform record into dictionary based with column infomation and table name

 @param table an instance that conform `BNCSQLiteTableProtocol` protocol
 @return the dicitonary of record data
 */
- (NSDictionary *)dictionaryRepresentationWithTable:(id<BNCSQLiteTableProtocol>)table;

/**
 config you record `property` with dictionary

 @param dictionary the data fetched with `id<BNCSQLiteTableProtocol>`
 */
- (void)objectRepresentationWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
