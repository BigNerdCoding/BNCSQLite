//
//  BNCSQLiteMigrationTestStep2.m
//  BNCSQLiteTests
//
//  Created by Jax Wu on 2018/7/10.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteMigrationTestStep2.h"
#import "NSString+BNCSQLiteSchema.h"
#import "BNCSQLiteTableColumn.h"

@implementation BNCSQLiteMigrationTestStep2

#pragma mark - BNCSQLiteMigrationStepProtocol

- (BOOL)goUpWithAction:(BNCSQLiteDatabase *)dbConnect {
    NSError *error = nil;
    
    BNCSQLiteTableColumn *column2 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version2" type:BNCSQLiteTableColumnTypeText constraint:nil];

    NSString *sql = [NSString addColumn:column2 tableName:@"migration_test_table"];
    
    return [dbConnect executeSQL:sql bind:nil rowHandle:nil error:&error];
}

@end
