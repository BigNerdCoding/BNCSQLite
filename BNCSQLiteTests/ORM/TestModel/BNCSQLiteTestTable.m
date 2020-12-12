//
//  BNCSQLiteTestTable.m
//  BNCSQLiteTests
//
//  Created by Jax Wu on 2018/7/2.
//  Copyright © 2018年 Jax Wu. All rights reserved.
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

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)allColumnInfo {
    BNCSQLiteTableColumn *column = [BNCSQLiteTableColumn primaryRowIDColWithName:@"rowID"];
    
    BNCSQLiteTableColumn *column2 = [BNCSQLiteTableColumn notNullColWithName:@"name" type:BNCSQLiteTableColumnTypeText];
    BNCSQLiteTableColumn *column3 = [BNCSQLiteTableColumn notNullColWithName:@"age" type:BNCSQLiteTableColumnTypeInt];
    
    BNCSQLiteTableColumn *column4 = [BNCSQLiteTableColumn intColWithName:@"isCelebrity"];
    
    BNCSQLiteTableColumn *column5 = [BNCSQLiteTableColumn binaryColWithName:@"bolbData"];
    
    BNCSQLiteTableColumn *column6 = [BNCSQLiteTableColumn realColWithName:@"progress"];
    BNCSQLiteTableColumn *column7 = [BNCSQLiteTableColumn textColWithName:@"nilText"];
    
    BNCSQLiteTableColumn *column8 = [[BNCSQLiteTableColumn alloc] initWithColName:@"defaultText" type:BNCSQLiteTableColumnTypeText constraint:^(BNCSQLiteTableColumn *column) {
        [column settingDefaultValueConstraint:@" '' "];
    }];
    
    BNCSQLiteTableColumn *column9 = [[BNCSQLiteTableColumn alloc] initWithColName:@"defaultInt" type:BNCSQLiteTableColumnTypeInt constraint:^(BNCSQLiteTableColumn *column) {
        [column settingDefaultValueConstraint:@" 0 "];
    }];
    
    BNCSQLiteTableColumn *column10 = [[BNCSQLiteTableColumn alloc] initWithColName:@"defaultReal" type:BNCSQLiteTableColumnTypeReal constraint:^(BNCSQLiteTableColumn *column) {
        [column settingDefaultValueConstraint:@" 0.0 "];
    }];
    
    BNCSQLiteTableColumn *column11 = [BNCSQLiteTableColumn uniqueColWithName:@"timeStamp" type:BNCSQLiteTableColumnTypeInt];
    
    return @[column, column2, column3, column4, column5, column6, column7, column8, column9, column10, column11];
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
