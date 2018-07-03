//
//  BNCSQLiteTable.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/2.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable.h"
#import "NSString+BNCSQLiteSchema.h"
#import "BNCSQLiteDatabasePool.h"
#import "BNCSQLiteDataBaseConfig+InfoProtocol.h"
#import "BNCSQLiteRecordProtocol.h"

@implementation BNCSQLiteTable

- (instancetype)init {
    self = [super init];
    
    if (self) {
        id record = [[[self recordClass] alloc] init];
        if (![record conformsToProtocol:@protocol(BNCSQLiteRecordProtocol)]) {
            NSException *exception =[NSException exceptionWithName:@"BNCSQLiteTableProtocol recordClass must conform BNCSQLiteRecordProtocol" reason:@"recordClass must conform BNCSQLiteRecordProtocol" userInfo:nil];
            
            @throw exception;
        }
    
        // Create Table & Index
        [self initTableWith:self.databaseInfo];
    }
    
    return self;
}

- (void)initTableWith:(id<BNCSQLiteDatabaseInfoProtocol>)databaseInfo {
    NSString *filePath = [databaseInfo databaseFilePath];
    NSAssert(filePath != nil, @"database filePath must not be nil");
    
    // Setup Connect
    BNCSQLiteDatabaseConfig *config = [[BNCSQLiteDatabaseConfig alloc] initWithProtocol:databaseInfo];
    BNCSQLiteDatabase *dbConnect = [[BNCSQLiteDatabasePool sharedInstance] databaseWithConfig:config];
    
    // Crate Table
    NSString *creatTableSQL = [NSString createTable:[self tableName] withColumns:[self columnInfo]];
    [dbConnect executeSQL:creatTableSQL bind:nil rowHandle:nil error:nil];
    
    // Crate table index if not exist
    if (![self respondsToSelector:@selector(indexList)]) {
        return;
    }
    
    NSArray *indexArr = [self performSelector:@selector(indexList)];
    for (id<BNCSQLiteTableColumnIndexProtocol> columnIndex in indexArr) {
        NSString *crateTableIndex = [NSString addIndex:columnIndex tableName:[self tableName]];
        [dbConnect executeSQL:crateTableIndex bind:nil rowHandle:nil error:nil];
    }
    
    return;
}


#pragma mark - BNCSQLiteTableProtocol
- (id<BNCSQLiteDatabaseInfoProtocol>)databaseInfo {
    NSException *exception =[NSException exceptionWithName:@"BNCSQLiteTableProtocol methods must be override" reason:@"databaseClass must be override" userInfo:nil];
    
    @throw exception;
}

- (NSString *)tableName {
    NSException *exception =[NSException exceptionWithName:@"BNCSQLiteTableProtocol methods must be override" reason:@"tableName must be override" userInfo:nil];
    
    @throw exception;
}

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)columnInfo {
    NSException *exception =[NSException exceptionWithName:@"BNCSQLiteTableProtocol methods must be override" reason:@"columnInfo must be override" userInfo:nil];
    
    @throw exception;
}

- (Class)recordClass {
    NSException *exception =[NSException exceptionWithName:@"BNCSQLiteTableProtocol methods must be override" reason:@"recordClass must be override" userInfo:nil];
    
    @throw exception;
}

@end
