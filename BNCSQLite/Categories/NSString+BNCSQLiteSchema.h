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

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BNCSQLiteSchema)

/**
 Generate create table sql string

 @param tableName tableName
 @param columns table columns
 @return create table sql string
 */
+ (instancetype)createTable:(NSString *)tableName withColumns:(NSArray<id<BNCSQLiteTableColumnProtocol> > *)columns;

/**
 Generate drop table sql string

 @param tableName tableName you want to drop
 @return drop table sql string
 */
+ (instancetype)dropTable:(NSString *)tableName;

/**
 Generate addColumn sql string

 @param column column you want to add
 @param tableName tableName
 @return  addColumn sql string
 */
+ (instancetype)addColumn:(id<BNCSQLiteTableColumnProtocol>)column tableName:(NSString *)tableName;

/**
 Generate addIndex sql string

 @param tableIndex index info you want to add
 @param tableName tableName
 @return addIndex SQL string
 */
+ (instancetype)addIndex:(id<BNCSQLiteTableColumnIndexProtocol>)tableIndex tableName:(NSString *)tableName;

/**
 Generate index drop sql string

 @param indexName index name you want to drop
 @return index drop sql string
 */
+ (instancetype)dropIndex:(NSString *)indexName;

/**
 Generate sql string that query table structure

 @param tableName tableName
 @return sql string
 */
+ (instancetype)columnInfoWithTableName:(NSString *)tableName;

@end

NS_ASSUME_NONNULL_END
