//
//  BNCSQLiteDatabasePool.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteDatabasePool.h"
#import "BNCSQLiteSafeCache.h"
#import "BNCSQLiteDatabaseInfoProtocol.h"

@interface BNCSQLiteDatabasePool()

@property(nonatomic, strong) BNCSQLiteSafeCache *dbCache;

@end

@implementation BNCSQLiteDatabasePool

+ (instancetype)sharedInstance {
    static BNCSQLiteDatabasePool *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BNCSQLiteDatabasePool alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dbCache = [[BNCSQLiteSafeCache alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNSThreadWillExitNotification:) name:NSThreadWillExitNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self closeAllDatabaseInCurrentThread];
}

- (BNCSQLiteDatabase *)databaseWithConfig:(BNCSQLiteDatabaseConfig *)config {
    if ([config.filePath isEqualToString:kBNCSQLiteTemporaryModePath] || [config.filePath isEqualToString:kBNCSQLiteMemoryModePath]) {
        return [[BNCSQLiteDatabase alloc] initWithConfig:config error:nil];
    }
    
    NSString *key = [NSString stringWithFormat:@"%@ - %@",config.filePath, [NSThread currentThread]];
    
    BNCSQLiteDatabase *dbConnect = [self.dbCache getCacheForKey:key];
    
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    
    if (dbConnect && [defaultFileManager fileExistsAtPath:config.filePath]) {
        return dbConnect;
    }
    
    if (dbConnect && ![defaultFileManager fileExistsAtPath:config.filePath]) {
        [self closeDatabaseInCurrentThread:config.filePath];
    }
    
    NSError *error = nil;
    
    dbConnect = [[BNCSQLiteDatabase alloc] initWithConfig:config error:&error];
    
    if (error) {
        NSLog(@"Error at %s:[%d]:%@", __FILE__, __LINE__, error);
    } else {
        [self.dbCache cacheObject:dbConnect forKey:key];
    }
    
    return dbConnect;
}

- (void)closeDatabaseInCurrentThread:(NSString *)filePath{
    NSMutableArray *databaseToClose = [NSMutableArray array];
    
    for (NSString *key in self.dbCache.getAllCacheKeys) {
        if ([key containsString:[NSString stringWithFormat:@"%@ - %@",filePath, [NSThread currentThread]]]) {
            [databaseToClose addObject:key];
        }
    }
    
    for (NSString *key in databaseToClose) {
        BNCSQLiteDatabase *dbConnect = [self.dbCache getCacheForKey:key];
        [dbConnect closeDatabase];
        [self.dbCache removeCacheObjectForKey:key];
    }
}

- (void)closeAllDatabaseInCurrentThread {
    NSMutableArray *databaseToClose = [NSMutableArray array];
    
    for (NSString *key in self.dbCache.getAllCacheKeys) {
        if ([key containsString:[NSString stringWithFormat:@"%@", [NSThread currentThread]]]) {
            [databaseToClose addObject:key];
        }
    }
    
    for (NSString *key in databaseToClose) {
        BNCSQLiteDatabase *dbConnect = [self.dbCache getCacheForKey:key];
        [dbConnect closeDatabase];
        [self.dbCache removeCacheObjectForKey:key];
    }
}



#pragma mark - event response
- (void)didReceiveNSThreadWillExitNotification:(NSNotification *)notification {
    [self closeAllDatabaseInCurrentThread];
}

@end
