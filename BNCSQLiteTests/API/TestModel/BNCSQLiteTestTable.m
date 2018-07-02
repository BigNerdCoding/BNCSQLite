//
//  BNCSQLiteTestTable.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/2.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTestTable.h"
#import "BNCSQLiteTestRecord.h"
#import "BNCSQLiteTestDatabase.h"
#import "BNCSQLiteTableColumn.h"

@implementation BNCSQLiteTestTable

#pragma mark - BNCSQLiteTableProtocol
- (Class)databaseClass {
   return [BNCSQLiteTestDatabase class];
}

- (NSString *)tableName {
    return @"test_table";
}

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)columnInfo {
    BNCSQLiteTableColumn *column = [BNCSQLiteTableColumn initRowIDColWithName:@"row_id"];
    
    return @[column];
}

- (Class)recordClass {
    return [BNCSQLiteTestRecord class];
}

@end
