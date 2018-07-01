//
//  BNCDataBaseTableProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCDataBaseTableColumnProtocol.h"

@protocol BNCSQLiteTableProtocol <NSObject>

@required

- (Class)databaseClass;

- (NSString *)tableName;

- (NSDictionary< id<BNCDataBaseTableColumnProtocol> > *)columnInfo;

- (Class)recordClass;

@end