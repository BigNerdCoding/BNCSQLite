//
//  BNCSQLiteTestRecord.h
//  BNCSQLiteTests
//
//  Created by Jax Wu on 2018/7/2.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteRecord.h"

@interface BNCSQLiteTestRecord : BNCSQLiteRecord

@property(nonatomic, strong) NSNumber *rowID;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) BOOL  isCelebrity;
@property(nonatomic, strong) NSData *bolbData;
@property(nonatomic, assign) double progress;
@property(nonatomic, strong) NSString *nilText;
@property(nonatomic, strong) NSString *defaultText;
@property(nonatomic, assign) NSInteger defaultInt;
@property(nonatomic, assign) double defaultReal;
@property(nonatomic, assign) long long timeStamp;

@end
