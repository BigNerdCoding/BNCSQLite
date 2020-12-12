//
//  BNCSQLiteTable.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/2.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableProtocol.h"

/**
 This is an abstract class that conform `BNCSQLiteTableProtocol` protocol, don't use it directly
 
 You can inherit `BNCSQLiteTable` or define your own class that conform `BNCSQLiteTableProtocol` protocol
 
 WARNING:
    if you inherit `BNCSQLiteTable` class , you should also implement the `BNCSQLiteTableProtocol` protocol.
 */
NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteTable : NSObject <BNCSQLiteTableProtocol>

/**
 the database connection
 */
@property(nonatomic, readonly) BNCSQLiteDatabase *dbConnect;

@end

NS_ASSUME_NONNULL_END
