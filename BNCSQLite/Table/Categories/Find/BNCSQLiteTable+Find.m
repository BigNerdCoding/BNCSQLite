//
//  BNCSQLiteTable+Find.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable+Find.h"

@implementation BNCSQLiteTable (Find)

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithError:(NSError **)error {
    return @[];
}

- (id<BNCSQLiteRecordProtocol>)findLatestRecordWithError:(NSError **)error {
    return nil;
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithWhereCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams isDistinct:(BOOL)isDistinct error:(NSError **)error {
    return @[];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithSQL:(NSString *)sqlString params:(NSDictionary *)params error:(NSError **)error {
    return @[];
}

- (id<BNCSQLiteRecordProtocol>)findFirstRowWithWhereCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams isDistinct:(BOOL)isDistinct error:(NSError **)error {
    return nil;
}

- (NSInteger)countTotalRecord {
    return 0;
}

- (NSInteger)countWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams error:(NSError **)error {
    return 0;
}

- (NSInteger)countWithSQL:(NSString *)sqlString params:(NSDictionary *)params error:(NSError **)error {
    return 0;
}

- (id<BNCSQLiteRecordProtocol>)findWithPrimaryKey:(NSNumber *)primaryKeyValue error:(NSError **)error {
    return nil;
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithKeyName:(NSString *)keyname value:(id)value error:(NSError **)error {
    return @[];
}

- (NSArray <id<BNCSQLiteRecordProtocol> > *)findAllWithKeyName:(NSString *)keyname inValueList:(NSArray *)valueList error:(NSError **)error {
    return @[];
}


@end
