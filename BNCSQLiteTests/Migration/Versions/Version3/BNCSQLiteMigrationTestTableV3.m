//
//  BNCSQLiteMigrationTestTableV3.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteMigrationTestTableV3.h"
#import "BNCSQLiteMigrationTestRecordV3.h"
#import "BNCSQLiteTestDatabaseV3.h"
#import "BNCSQLiteTableColumn.h"
#import "BNCSQLiteTableColumnIndex.h"

@implementation BNCSQLiteMigrationTestTableV3

#pragma mark - BNCSQLiteTableProtocol
- (id<BNCSQLiteDatabaseInfoProtocol>)databaseInfo  {
    return [[BNCSQLiteTestDatabaseV3 alloc] init];
}

- (NSString *)tableName {
    return @"migration_test_table";
}

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)allColumnInfo {
    BNCSQLiteTableColumn *column0 = [BNCSQLiteTableColumn primaryRowIDColWithName:@"rowID"];
    
    BNCSQLiteTableColumn *column1 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version1" type:BNCSQLiteTableColumnTypeText constraint:^(BNCSQLiteTableColumn *column) {
        [column settingDefaultValueConstraint:@" '' "];
    }];
    
    BNCSQLiteTableColumn *column2 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version2" type:BNCSQLiteTableColumnTypeText constraint:nil];
    
    BNCSQLiteTableColumn *column3 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version3" type:BNCSQLiteTableColumnTypeText constraint:nil];
    
    return @[column0, column1, column2, column3];
}

- (Class)recordClass {
    return [BNCSQLiteMigrationTestRecordV3 class];
}

- (NSString *)primaryKeyName {
    return @"rowID";
}

@end
