//
//  BNCSQLiteAsyncExecutor.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/10.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteAsyncExecutor : NSObject

/**
 *  you should always use shared instance to perform asynchronize action
 *
 *  @return return the shared instance
 */
+ (instancetype)sharedInstance;

/**
 database async write action

 @param writeAction action block
 */
- (void)asyncWrite:(void (^)(void))writeAction;

/**
 database async read action

 @param readAction read block
 */
- (void)asyncRead:(void (^)(void))readAction;

@end

NS_ASSUME_NONNULL_END
