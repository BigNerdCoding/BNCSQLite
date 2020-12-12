//
//  BNCSQLiteSafeCache.m
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/1.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteSafeCache.h"

@interface BNCSQLiteSafeCache()

@property(strong, nonatomic) dispatch_queue_t  actionQueue;
@property(strong, nonatomic) NSMutableDictionary    *cacheDic;

@end

@implementation BNCSQLiteSafeCache

-(instancetype)init {
    self = [super init];
    if (self) {
        _actionQueue = dispatch_queue_create("com.bignerdcoding.bncsqlite.safeCache",DISPATCH_QUEUE_CONCURRENT);
        _cacheDic = [[NSMutableDictionary alloc] initWithCapacity:7];
    }
    
    return self;
}

-(void)cacheObject:(id)object forKey:(NSString *)key {
    dispatch_barrier_async(self.actionQueue, ^{
        [self.cacheDic setObject:object forKey:key];
    });
}

-(id)getCacheForKey:(NSString *)key {
    __block id object = nil;
    
    dispatch_sync(self.actionQueue,^{
        object = [self.cacheDic objectForKey:key];
    });
    
    return object;
}

-(void)removeCacheObjectForKey:(NSString *)key {
    dispatch_barrier_async(self.actionQueue, ^{
        [self.cacheDic removeObjectForKey:key];
    });
}

-(void)removeAllCacheObjects {
    dispatch_barrier_async(self.actionQueue, ^{
        [self.cacheDic removeAllObjects];
    });
}

-(NSArray<NSString *> *)getAllCacheKeys {
    __block NSMutableArray *allKeys = [[NSMutableArray alloc] initWithCapacity:3];
    
    dispatch_sync(self.actionQueue, ^{
        allKeys = [[self.cacheDic allKeys] mutableCopy];
    });
    
    return allKeys;
}

@end
