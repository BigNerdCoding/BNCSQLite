//
//  BNCSQLiteMigrationTestTableV2.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteMigrationTestTableV2.h"
#import "BNCSQLiteMigrationTestRecordV2.h"
#import "BNCSQLiteTestDatabaseV2.h"
#import "BNCSQLiteTableColumn.h"
#import "BNCSQLiteTableColumnIndex.h"

@implementation BNCSQLiteMigrationTestTableV2

#pragma mark - BNCSQLiteTableProtocol
- (id<BNCSQLiteDatabaseInfoProtocol>)databaseInfo  {
    return [[BNCSQLiteTestDatabaseV2 alloc] init];
}

- (NSString *)tableName {
    return @"migration_test_table";
}

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)columnInfo {
    BNCSQLiteTableColumn *column0 = [BNCSQLiteTableColumn initPrimaryColWithName:@"rowID"];
    
    BNCSQLiteTableColumn *column1 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version1" type:BNCSQLiteTableColumnTypeText constraint:^(BNCSQLiteTableColumn *column) {
        [column settingDefaultValueConstraint:@" '' "];
    }];
    
    BNCSQLiteTableColumn *column2 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version2" type:BNCSQLiteTableColumnTypeText constraint:nil];
    
    return @[column0, column1, column2];
}

- (Class)recordClass {
    return [BNCSQLiteMigrationTestRecordV2 class];
}

- (NSString *)primaryKeyName {
    return @"rowID";
}

@end
