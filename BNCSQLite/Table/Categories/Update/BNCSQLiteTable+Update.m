//
//  BNCSQLiteTable+Update.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable+Update.h"

@implementation BNCSQLiteTable (Update)

/**
 *  update a record
 *
 *  @param record the record you want to update
 *  @param error  error if fails
 */
- (BOOL)updateRecord:(id<BNCSQLiteRecordProtocol>)record error:(NSError **)error {
    return YES;
}

- (BOOL)updateRecordList:(NSArray <id<BNCSQLiteRecordProtocol> > *)recordList error:(NSError **)error {
    return YES;
}

- (BOOL)updateValue:(id)value forKey:(NSString *)key whereCondition:(NSString *)whereCondition whereConditionParams:(NSDictionary *)whereConditionParams error:(NSError **)error {
    return YES;
}

- (BOOL)updateKeyValueList:(NSDictionary *)keyValueList whereCondition:(NSString *)whereCondition whereConditionParams:(NSDictionary *)whereConditionParams error:(NSError **)error {
    return YES;
}

- (BOOL)updateValue:(id)value forKey:(NSString *)key whereKey:(NSString *)wherekey inList:(NSArray *)valueList error:(NSError *__autoreleasing *)error {
    return YES;
}

- (BOOL)updateValue:(id)value forKey:(NSString *)key primaryKeyValue:(NSNumber *)primaryKeyValue error:(NSError **)error {
    return YES;
}

- (BOOL)updateKeyValueList:(NSDictionary *)keyValueList primaryKeyValue:(NSNumber *)primaryKeyValue error:(NSError **)error {
    return YES;
}

@end
