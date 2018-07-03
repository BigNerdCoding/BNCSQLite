//
//  BNCSQLiteDataBaseConfig+Protocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteDataBaseConfig.h"
#import "BNCSQLiteDataBaseProtocol.h"

@interface BNCSQLiteDataBaseConfig (Protocol)

- (instancetype)initWithProtocol:(id<BNCSQLiteDataBaseProtocol>)protocol;

@end
