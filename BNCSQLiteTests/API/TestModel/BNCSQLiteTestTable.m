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
- (Class)databaseClass {
   return [BNCSQLiteTestDatabase class];
}

- (NSString *)tableName {
    return @"test_table";
}

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)columnInfo {
    BNCSQLiteTableColumn *column = [BNCSQLiteTableColumn initRowIDColWithName:@"row_id"];
    BNCSQLiteTableColumn *column2 = [[BNCSQLiteTableColumn alloc] initWithColName:@"text_index_col" type:BNCSQLiteTableColumnTypeInt constraint:^(BNCSQLiteTableColumn *column) {
        [column settingNotNullConstraint];
        [column settingDefaultValueConstraint:@"0"];
    }];
    
    return @[column,column2];
}

- (Class)recordClass {
    return [BNCSQLiteTestRecord class];
}

- (NSArray< id<BNCSQLiteTableColumnIndexProtocol> > *)indexList {
    BNCSQLiteTableColumnIndex *index = [[BNCSQLiteTableColumnIndex alloc] initWithIndexName:@"index_test" fields:@[@"text_index_col"]];
    
    return @[index];
}

@end
