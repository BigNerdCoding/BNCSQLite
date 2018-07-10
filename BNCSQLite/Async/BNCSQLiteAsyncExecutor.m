//
//  BNCSQLiteAsyncExecutor.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteAsyncExecutor.h"

@interface BNCSQLiteAsyncExecutor()

@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation BNCSQLiteAsyncExecutor

#pragma mark - public methods
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static BNCSQLiteAsyncExecutor *shareInstance = nil;
    dispatch_once(&onceToken, ^{
        shareInstance = [[BNCSQLiteAsyncExecutor alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.queue = dispatch_queue_create("com.bignerdcoding.threadSafe.async", DISPATCH_QUEUE_CONCURRENT);
    }
    
    return self;
}

#pragma mark - public methods
- (void)write:(void (^)(void))writeAction {
    dispatch_barrier_async(self.queue, ^{
        writeAction();
    });
}

- (void)read:(void (^)(void))readAction {
    dispatch_async(self.queue, ^{
        readAction();
    });
}

@end
