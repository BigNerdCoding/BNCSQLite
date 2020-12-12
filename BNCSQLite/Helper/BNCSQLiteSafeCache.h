//
//  BNCSQLiteSafeCache.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/1.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteSafeCache : NSObject

/**
 cache the object
 
 @param object object want to cache
 @param key key of the cache object
 */
-(void)cacheObject:(id)object forKey:(NSString *)key;

/**
 fetch th cached object
 
 @param key  key of the cache object
 @return cached object
 */
-(id)getCacheForKey:(NSString *)key;

/**
 revome the cache object
 
 @param key key of the cache object
 */
-(void)removeCacheObjectForKey:(NSString *)key;

/**
 remove all cached objects
 */
-(void)removeAllCacheObjects;

/**
 get all cache key
 
 @return all cache key
 */
-(NSArray<NSString *> *)getAllCacheKeys;

@end

NS_ASSUME_NONNULL_END
