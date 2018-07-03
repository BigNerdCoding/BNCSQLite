//
//  BNCSQLiteDataBaseConfig+Protocol.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteDataBaseConfig+Protocol.h"
#import "BNCSQLiteDataBase.h"

@implementation BNCSQLiteDataBaseConfig (Protocol)

- (instancetype)initWithProtocol:(id<BNCSQLiteDataBaseProtocol>)protocol {
    self = [super init];
    if (self) {
        self.filePath = [protocol databaseFilePath];
        self.latestSchemaVersion = [self latestVersionWithConfig:protocol];
        self.migrationAction = [self generateMigrationWithConfig:protocol];
    }
    
    return self;
}

#pragma mark - Migration Action
-(NSString *)latestVersionWithConfig:(id<BNCSQLiteDataBaseProtocol>)config {
    NSString *schemaVersion = kBNCSQLiteInitVersion;
    
    if(![config respondsToSelector:@selector(databaseMigrator)]) {
        // Don't Need Migrator
        return schemaVersion;
    }
    
    id<BNCSQLiteMigratorProtocol> migrator = nil;
    
    migrator = [config performSelector:@selector(databaseMigrator)];
    
    NSArray *versionList = [migrator migrationVersionList];
    
    if (versionList.count > 0) {
       schemaVersion = [versionList lastObject];
    }
    
    return schemaVersion;
}

-(MigrationBlock)generateMigrationWithConfig:(id<BNCSQLiteDataBaseProtocol>)config {
    
    if(![config respondsToSelector:@selector(databaseMigrator)]) {
        // Don't Need Migrator
        return nil;
    }
    
    if (![config respondsToSelector:@selector(migrationStepDictionary)]) {
        // Don't Need Migrator
        return nil;
    }
    
    id<BNCSQLiteMigratorProtocol> migrator = nil;
    
    migrator = [config performSelector:@selector(databaseMigrator)];
    
    NSArray *versionList = [migrator migrationVersionList];
    NSDictionary *stepDictionary = [migrator migrationStepDictionary];
    
    NSAssert(versionList.count == stepDictionary.allKeys.count, @"migrationVersionList & migrationStepDictionary quantity must be equal ");
    
    if (versionList.count != stepDictionary.allKeys.count) {
        return nil;
    }
    
    MigrationBlock action = ^(BNCSQLiteDataBase *dbConnct) {
        // Do Version Migration
        BOOL shouldMigration = NO;
        
        for (NSString *version in versionList) {
            if (shouldMigration) {
                id<BNCSQLiteMigrationStepProtocol> step = [stepDictionary objectForKey:version];
                
                if (![step goUpWithQueryCommand:dbConnct]) {
                    [step goDownWithQueryCommand:dbConnct];
                    return NO;
                }
                
                [dbConnct updateSchemaVersion:version];
            }
            
            if ([version isEqualToString:[dbConnct currentVersion]]) {
                shouldMigration = YES;
            }
        }
        
        return YES;
    };
    
    return action;
}
@end
