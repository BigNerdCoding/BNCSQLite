//
//  BNCSQLiteTableColumnIndexProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BNCSQLiteTableColumnIndexProtocol <NSObject>

@required
- (BOOL)isUniqueIndex;

- (NSString *)indexName;

- (NSArray<NSString *> *)indexCloumnFields;

@end
