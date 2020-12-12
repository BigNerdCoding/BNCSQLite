//
//  BNCSQLiteDatabaseConfig+InfoProtocol.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/3.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteDatabaseConfig.h"
#import "BNCSQLiteDatabaseInfoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteDatabaseConfig (InfoProtocol)

/**
 crate a config instance using `id<BNCSQLiteDatabaseInfoProtocol>` object

 @param infoProtocol an instance that conform BNCSQLiteDatabaseInfoProtocol
 @return a config instance
 */
- (instancetype)initWithProtocol:(id<BNCSQLiteDatabaseInfoProtocol>)infoProtocol;

@end

NS_ASSUME_NONNULL_END
