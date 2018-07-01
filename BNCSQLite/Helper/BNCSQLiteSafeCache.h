//
//  BNCSQLiteSafeCache.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNCSQLiteSafeCache : NSObject

/**
 缓存数据
 
 @param object 待缓存对象
 @param key 缓存键
 */
-(void)cacheObject:(id)object forKey:(NSString *)key;

/**
 取出缓存数据
 
 @param key 缓存键
 @return 缓存对象
 */
-(id)getCacheForKey:(NSString *)key;

/**
 移除缓存对象
 
 @param key 待移除对象键
 */
-(void)removeCacheObjectForKey:(NSString *)key;

/**
 移除所有缓存对象
 */
-(void)removeAllCacheObjects;

/**
 返回所有 key
 
 @return 返回所有健
 */
-(NSArray<NSString *> *)getAllCacheKeys;

@end
