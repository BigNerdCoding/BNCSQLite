//
//  BNCSQLiteDatabaseConfig+InfoProtocol.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteDatabaseConfig+InfoProtocol.h"
#import "BNCSQLiteDatabase.h"

@implementation BNCSQLiteDatabaseConfig (InfoProtocol)

- (instancetype)initWithProtocol:(id<BNCSQLiteDatabaseInfoProtocol>)infoProtocol {
    self = [super init];
    if (self) {
        self.filePath = [infoProtocol databaseFilePath];
        self.latestSchemaVersion = [self latestVersionWithConfig:infoProtocol];
        self.migrationAction = [self generateMigrationWithConfig:infoProtocol];
    }
    
    return self;
}

#pragma mark - Migration Action
-(NSString *)latestVersionWithConfig:(id<BNCSQLiteDatabaseInfoProtocol>)infoProtocol {
    NSString *schemaVersion = kBNCSQLiteInitVersion;
    
    if(![infoProtocol respondsToSelector:@selector(databaseMigrator)]) {
        // Don't Need Migrator
        return schemaVersion;
    }
    
    id<BNCSQLiteMigratorProtocol> migrator = nil;
    
    migrator = [infoProtocol performSelector:@selector(databaseMigrator)];
    
    NSArray *versionList = [migrator migrationVersionList];
    
    if (versionList.count > 0) {
       schemaVersion = [versionList lastObject];
    }
    
    return schemaVersion;
}

-(MigrationBlock)generateMigrationWithConfig:(id<BNCSQLiteDatabaseInfoProtocol>)infoProtocol {
    
    if(![infoProtocol respondsToSelector:@selector(databaseMigrator)]) {
        // Don't Need Migrator
        return nil;
    }
    
    if (![infoProtocol respondsToSelector:@selector(migrationStepDictionary)]) {
        // Don't Need Migrator
        return nil;
    }
    
    id<BNCSQLiteMigratorProtocol> migrator = nil;
    
    migrator = [infoProtocol performSelector:@selector(databaseMigrator)];
    
    NSArray *versionList = [migrator migrationVersionList];
    NSDictionary *stepDictionary = [migrator migrationStepDictionary];
    
    NSAssert(versionList.count == stepDictionary.allKeys.count, @"migrationVersionList & migrationStepDictionary quantity must be equal ");
    
    if (versionList.count != stepDictionary.allKeys.count) {
        // Not Equal Don't Do Migrator
        return nil;
    }
    
    MigrationBlock action = ^(BNCSQLiteDatabase *dbConnct) {
        // Do Version Migration
        BOOL shouldMigration = NO;
        
        for (NSString *version in versionList) {
            if (shouldMigration) {
                id<BNCSQLiteMigrationStepProtocol> step = [stepDictionary objectForKey:version];
                
                if (![step goUpWithQueryCommand:dbConnct]) {
                    [step goDownWithQueryCommand:dbConnct];
                    break;
                }
                
                [dbConnct updateSchemaVersion:version];
            }
            
            if ([version isEqualToString:[dbConnct currentVersion]]) {
                shouldMigration = YES;
            }
        }
    };
    
    return action;
}
@end
