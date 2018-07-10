//
//  BNCSQLiteMigrationTestStep3.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteMigrationTestStep3.h"
#import "NSString+BNCSQLiteSchema.h"
#import "BNCSQLiteTableColumn.h"

@implementation BNCSQLiteMigrationTestStep3

#pragma mark - BNCSQLiteMigrationStepProtocol

- (BOOL)goUpWithQueryCommand:(BNCSQLiteDatabase *)dbConnect {
    NSError *error = nil;
    
    BNCSQLiteTableColumn *column3 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version3" type:BNCSQLiteTableColumnTypeText constraint:nil];
    
    NSString *sql = [NSString addColumn:column3 tableName:@"migration_test_table"];
    
    return [dbConnect executeSQL:sql bind:nil rowHandle:nil error:&error];
}


@end
