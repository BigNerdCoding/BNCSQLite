//
//  BNCSQLiteRecord.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/3.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteRecordProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 This is an abstract class that conform `BNCSQLiteRecordProtocol` protocol, don't use it directly
 
 You can inherit `BNCSQLiteTable` or define your own class the conform `BNCSQLiteRecordProtocol` protocol
 
 */
@interface BNCSQLiteRecord : NSObject <BNCSQLiteRecordProtocol>

@end

NS_ASSUME_NONNULL_END
