//
//  BNCSQLiteTableProtocol.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/1.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteTableColumnProtocol.h"
#import "BNCSQLiteTableColumnIndexProtocol.h"
#import "BNCSQLiteDatabaseInfoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BNCSQLiteTableProtocol <NSObject>

@required

/**
 an instance that conform `BNCSQLiteDatabaseInfoProtocol` protocol

 @return an instance that conform `BNCSQLiteDatabaseInfoProtocol` protocol
 */
- (id<BNCSQLiteDatabaseInfoProtocol>)databaseInfo;

/**
 return the table name

 @return table name
 */
- (NSString *)tableName;

/**
 return the table all column information

 @return the all column information
 */
- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)allColumnInfo;

/**
 Class of the record that  corresponding to the table, which must be confrom `BNCSQLiteRecordProtocol`
 
 @return the model class info
 */
- (Class)recordClass;

/**
 the name of the primary key
 @return the name of the primary key
 */
- (NSString *)primaryKeyName;

@optional

/**
 the index list of the table

 @return table index list
 */
- (NSArray< id<BNCSQLiteTableColumnIndexProtocol> > *)indexList;

@end

NS_ASSUME_NONNULL_END
