//
//  BNCSQLiteTable+Delete.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable+Delete.h"

@implementation BNCSQLiteTable (Delete)

- (BOOL)deleteRecord:(id<BNCSQLiteRecordProtocol>)record error:(NSError **)error {
    return YES;
}

- (BOOL)deleteRecordList:(NSArray <id<BNCSQLiteRecordProtocol> > *)recordList error:(NSError **)error {
    return YES;
}

- (BOOL)deleteWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams error:(NSError **)error {
    return YES;
}

- (BOOL)deleteWithPrimaryKey:(NSNumber *)primaryKeyValue error:(NSError **)error {
    return YES;
}

- (BOOL)deleteWithPrimaryKeyList:(NSArray <NSNumber *> *)primaryKeyValueList error:(NSError **)error {
    return YES;
}

- (BOOL)deleteRecordWhereKey:(NSString *)key value:(id)value error:(NSError **)error {
    return YES;
}

- (BOOL)truncate {
    return YES;
}

@end
