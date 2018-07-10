//
//  BNCSQLiteAsyncExecutor.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNCSQLiteAsyncExecutor : NSObject

/**
 *  you should always use shared instance to perform asynchronize action
 *
 *  @return return the shared instance
 */
+ (instancetype)sharedInstance;

- (void)write:(void (^)(void))writeAction;

- (void)read:(void (^)(void))readAction;

@end
