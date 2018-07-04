//
//  BNCSQLiteRecordProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableProtocol.h"
@protocol BNCSQLiteRecordProtocol <NSObject>

@required

- (NSDictionary *)dictionaryRepresentationWithTable:(id<BNCSQLiteTableProtocol>)table;

- (void)objectRepresentationWithDictionary:(NSDictionary *)dictionary;

@end
