//
//  BNCSQLiteDatabaseConfig+InfoProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteDatabaseConfig.h"
#import "BNCSQLiteDatabaseInfoProtocol.h"

@interface BNCSQLiteDatabaseConfig (InfoProtocol)

- (instancetype)initWithProtocol:(id<BNCSQLiteDatabaseInfoProtocol>)infoProtocol;

@end
