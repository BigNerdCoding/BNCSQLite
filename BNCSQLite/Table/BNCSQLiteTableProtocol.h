//
//  BNCSQLiteTableProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableColumnProtocol.h"
#import "BNCSQLiteTableColumnIndexProtocol.h"
#import "BNCSQLiteDatabaseInfoProtocol.h"

@protocol BNCSQLiteTableProtocol <NSObject>

@required

- (id<BNCSQLiteDatabaseInfoProtocol>)databaseInfo;

- (NSString *)tableName;

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)columnInfo;

- (Class)recordClass;

@optional
- (NSArray< id<BNCSQLiteTableColumnIndexProtocol> > *)indexList;

@end
