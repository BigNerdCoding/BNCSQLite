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
 return the table column information

 @return the column information
 */
- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)columnInfo;

/**
 Class of the record that  corresponding to the table, which must be confrom `BNCSQLiteRecordProtocol`
 
 @return the model class info
 */
- (Class)recordClass;

@optional

/**
 the index list of the table

 @return table index list
 */
- (NSArray< id<BNCSQLiteTableColumnIndexProtocol> > *)indexList;

@end
