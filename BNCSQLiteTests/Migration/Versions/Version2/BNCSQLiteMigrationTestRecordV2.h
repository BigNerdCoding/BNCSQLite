//
//  BNCSQLiteMigrationTestRecordV2.h
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteRecord.h"

@interface BNCSQLiteMigrationTestRecordV2 : BNCSQLiteRecord

@property(nonatomic, strong) NSNumber *rowID;
@property(nonatomic, strong) NSString *version1;
@property(nonatomic, strong) NSString *version2;

@end
