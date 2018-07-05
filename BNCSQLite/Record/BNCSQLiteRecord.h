//
//  BNCSQLiteRecord.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteRecordProtocol.h"
/**
 This is an abstract class that conform `BNCSQLiteRecordProtocol` protocol, don't use it directly
 
 You can inherit `BNCSQLiteTable` or define your own class the conform `BNCSQLiteRecordProtocol` protocol
 
 */

@interface BNCSQLiteRecord : NSObject <BNCSQLiteRecordProtocol>

@end
