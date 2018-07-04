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
 
 Except for WITHOUT ROWID tables, all rows within SQLite tables have a 64-bit signed integer key that uniquely identifies the row within its table.
 
 This is to say: if the table don't have the primary key, there is a 'hidden' primary key - rowid (if not  have this column  in explicited)
 
 Warning: Don't declare a property with name `rowid` if there don't have explicit primary key column
 
 References:
    https://www.sqlite.org/lang_createtable.html
    https://www.sqlite.org/withoutrowid.html
 */

@interface BNCSQLiteRecord : NSObject <BNCSQLiteRecordProtocol>

@end
