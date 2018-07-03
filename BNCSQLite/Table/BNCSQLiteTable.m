//
//  BNCSQLiteTable.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/2.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable.h"
#import "BNCSQLiteDataBaseProtocol.h"
#import "BNCSQLiteDatabasePool.h"
#import "NSString+BNCSQLiteSchema.h"
#import "BNCSQLiteDataBaseConfig+Protocol.h"

@implementation BNCSQLiteTable

- (instancetype)init {
    self = [super init];
    
    if (self) {
        id database = [[[self databaseClass] alloc] init];
        if (![database conformsToProtocol:@protocol(BNCSQLiteDataBaseProtocol)]) {
            NSException *exception =[NSException exceptionWithName:@"BNCSQLiteTableProtocol databaseClass must conform BNCSQLiteDataBaseProtocol" reason:@"databaseClass must conform BNCSQLiteDataBaseProtocol" userInfo:nil];
            
            @throw exception;
        }
    
        // Create Table & Index
        [self initTableWith:database];
        
        // Migration
        
        
    }
    
    return self;
}

- (void)initTableWith:(id<BNCSQLiteDataBaseProtocol>)database {
    NSString *filePath = [database databaseFilePath];
    NSAssert(filePath != nil, @"database filePath must not be nil");
    
    // Setup Connect
    BNCSQLiteDataBaseConfig *config = [[BNCSQLiteDataBaseConfig alloc] initWithProtocol:database];
    BNCSQLiteDataBase *dbConnect = [[BNCSQLiteDatabasePool sharedInstance] databaseWithConfig:config];
    
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
- (Class)databaseClass {
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
