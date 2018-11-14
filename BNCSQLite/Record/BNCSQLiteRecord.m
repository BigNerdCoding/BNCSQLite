//
//  BNCSQLiteRecord.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteRecord.h"
#import <objc/runtime.h>

@implementation BNCSQLiteRecord

- (NSDictionary *)dictionaryRepresentationWithTable:(id<BNCSQLiteTableProtocol>)table {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableDictionary *propertyList = [[NSMutableDictionary alloc] init];
    while (count --> 0) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[count])];
        id value = [self valueForKey:key];
        if (value == nil) {
            propertyList[key] = [NSNull null];
        } else {
            propertyList[key] = value;
        }
    }
    free(properties);
    
    // Check data
    NSMutableDictionary *dictionaryRepresentation = [[NSMutableDictionary alloc] init];
    
    for (id<BNCSQLiteTableColumnProtocol> column in table.allColumnInfo) {
        NSString *columnName = [column columnName];
        if (!propertyList[columnName]) {
            continue;
        }
        
        if (propertyList[columnName] == [NSNull null]) {
            continue;
        }
        
        dictionaryRepresentation[columnName] = propertyList[columnName];
    }
    
    return dictionaryRepresentation;
}

- (void)objectRepresentationWithDictionary:(NSDictionary *)dictionary {
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
        [self setValue:value forKey:key];
    }];
}

@end
