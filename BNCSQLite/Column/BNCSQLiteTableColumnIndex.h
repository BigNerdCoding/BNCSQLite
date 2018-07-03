//
//  BNCSQLiteTableColumnIndex.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableColumnIndexProtocol.h"

@interface BNCSQLiteTableColumnIndex : NSObject <BNCSQLiteTableColumnIndexProtocol>

- (instancetype)initWithIndexName:(NSString *)indexName fields:(NSArray<NSString *> *)fileds;

- (instancetype)initWithUniqueIndexName:(NSString *)indexName fields:(NSArray<NSString *> *)fields;

@end
