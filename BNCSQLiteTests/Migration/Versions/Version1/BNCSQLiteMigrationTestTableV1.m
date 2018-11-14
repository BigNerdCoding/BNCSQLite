//
//  BNCSQLiteMigrationTestTableV1.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteMigrationTestTableV1.h"
#import "BNCSQLiteMigrationTestRecordV1.h"
#import "BNCSQLiteTestDatabaseV1.h"
#import "BNCSQLiteTableColumn.h"
#import "BNCSQLiteTableColumnIndex.h"

@implementation BNCSQLiteMigrationTestTableV1

#pragma mark - BNCSQLiteTableProtocol
- (id<BNCSQLiteDatabaseInfoProtocol>)databaseInfo  {
    return [[BNCSQLiteTestDatabaseV1 alloc] init];
}

- (NSString *)tableName {
    return @"migration_test_table";
}

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)allColumnInfo {
    BNCSQLiteTableColumn *column0 = [BNCSQLiteTableColumn primaryRowIDColWithName:@"rowID"];
    
    BNCSQLiteTableColumn *column1 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version1" type:BNCSQLiteTableColumnTypeText constraint:^(BNCSQLiteTableColumn *column) {
        [column settingDefaultValueConstraint:@" '' "];
    }];
    
    return @[column0, column1];
}

- (Class)recordClass {
    return [BNCSQLiteMigrationTestRecordV1 class];
}

- (NSString *)primaryKeyName {
    return @"rowID";
}

@end
