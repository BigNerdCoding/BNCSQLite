//
//  BNCSQLiteTableProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableColumnProtocol.h"

@protocol BNCSQLiteTableProtocol <NSObject>

@required

- (Class)databaseClass;

- (NSString *)tableName;

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)columnInfo;

- (Class)recordClass;

@end
