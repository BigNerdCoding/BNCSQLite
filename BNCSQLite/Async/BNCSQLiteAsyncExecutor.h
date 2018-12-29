//
//  BNCSQLiteAsyncExecutor.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
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

- (void)asyncWrite:(void (^)(void))writeAction;

- (void)asyncRead:(void (^)(void))readAction;

@end

NS_ASSUME_NONNULL_END
