//
//  BNCSQLiteMigrationTestTableV4.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteMigrationTestTableV4.h"
#import "BNCSQLiteMigrationTestRecordV4.h"
#import "BNCSQLiteTestDatabaseV4.h"
#import "BNCSQLiteTableColumn.h"
#import "BNCSQLiteTableColumnIndex.h"

@implementation BNCSQLiteMigrationTestTableV4

#pragma mark - BNCSQLiteTableProtocol
- (id<BNCSQLiteDatabaseInfoProtocol>)databaseInfo  {
    return [[BNCSQLiteTestDatabaseV4 alloc] init];
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
    
    BNCSQLiteTableColumn *column4 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version4" type:BNCSQLiteTableColumnTypeText constraint:nil];
    
    return @[column0, column1, column2, column3, column4];
}

- (Class)recordClass {
    return [BNCSQLiteMigrationTestRecordV4 class];
}

- (NSString *)primaryKeyName {
    return @"rowID";
}

@end
