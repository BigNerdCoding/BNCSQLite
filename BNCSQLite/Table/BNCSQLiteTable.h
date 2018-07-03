//
//  BNCSQLiteTable.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/2.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableProtocol.h"

/**
 This is an abstract class that conform `BNCSQLiteTableProtocol` protocol, don't use it directly
 
 You can inherit `BNCSQLiteTable` or define your own class the conform `BNCSQLiteTableProtocol` protocol
 */
@interface BNCSQLiteTable : NSObject <BNCSQLiteTableProtocol>

@end
