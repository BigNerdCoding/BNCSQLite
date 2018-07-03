//
//  NSString+BNCSQLiteSchema.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/2.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableColumnProtocol.h"
#import "BNCSQLiteTableColumnIndexProtocol.h"

@interface NSString (BNCSQLiteSchema)

+ (instancetype)createTable:(NSString *)tableName withColumns:(NSArray<id<BNCSQLiteTableColumnProtocol> > *)columns;

+ (instancetype)dropTable:(NSString *)tableName;

+ (instancetype)addColumn:(id<BNCSQLiteTableColumnProtocol>)column tableName:(NSString *)tableName;

+ (instancetype)addIndex:(id<BNCSQLiteTableColumnIndexProtocol>)tableIndex tableName:(NSString *)tableName;

+ (instancetype)dropIndex:(NSString *)indexName;

+ (instancetype)columnInfoWithTableName:(NSString *)tableName;

@end
