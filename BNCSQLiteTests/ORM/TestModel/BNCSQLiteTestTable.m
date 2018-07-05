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
#import "BNCSQLiteTableColumnIndex.h"

@implementation BNCSQLiteTestTable

#pragma mark - BNCSQLiteTableProtocol
- (id<BNCSQLiteDatabaseInfoProtocol>)databaseInfo  {
   return [[BNCSQLiteTestDatabase alloc] init];
}

- (NSString *)tableName {
    return @"test_table";
}

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)columnInfo {
    BNCSQLiteTableColumn *column = [BNCSQLiteTableColumn initPrimaryColWithName:@"rowID"];
    
    BNCSQLiteTableColumn *column2 = [BNCSQLiteTableColumn initNotNullColWithName:@"name" type:BNCSQLiteTableColumnTypeText];
    BNCSQLiteTableColumn *column3 = [BNCSQLiteTableColumn initNotNullColWithName:@"age" type:BNCSQLiteTableColumnTypeInt];
    
    BNCSQLiteTableColumn *column4 = [[BNCSQLiteTableColumn alloc] initWithColName:@"isCelebrity" type:BNCSQLiteTableColumnTypeInt constraint:nil];
    
    BNCSQLiteTableColumn *column5 = [[BNCSQLiteTableColumn alloc] initWithColName:@"bolbData" type:BNCSQLiteTableColumnTypeBinary constraint:nil];
    BNCSQLiteTableColumn *column6 = [[BNCSQLiteTableColumn alloc] initWithColName:@"progress" type:BNCSQLiteTableColumnTypeReal constraint:nil];
    BNCSQLiteTableColumn *column7 = [[BNCSQLiteTableColumn alloc] initWithColName:@"nilText" type:BNCSQLiteTableColumnTypeText constraint:nil];
    BNCSQLiteTableColumn *column8 = [BNCSQLiteTableColumn initUniqueColWithName:@"timeStamp" type:BNCSQLiteTableColumnTypeInt];
    
    return @[column, column2, column3, column4, column5, column6, column7, column8];
}

- (Class)recordClass {
    return [BNCSQLiteTestRecord class];
}

- (NSString *)primaryKeyName {
    return @"rowID";
}

- (NSArray< id<BNCSQLiteTableColumnIndexProtocol> > *)indexList {
    BNCSQLiteTableColumnIndex *index = [[BNCSQLiteTableColumnIndex alloc] initWithIndexName:@"index_test" fields:@[@"age",@"timeStamp"]];
    
    return @[index];
}

@end