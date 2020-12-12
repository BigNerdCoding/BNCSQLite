//
//  BNCSQLiteDatabaseConfig+InfoProtocol.m
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/3.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteDatabaseConfig+InfoProtocol.h"
#import "BNCSQLiteDatabase.h"

@implementation BNCSQLiteDatabaseConfig (InfoProtocol)

- (instancetype)initWithProtocol:(id<BNCSQLiteDatabaseInfoProtocol>)infoProtocol {
    self = [super init];
    if (self) {
        self.filePath = [infoProtocol databaseFilePath];
        self.latestSchemaVersion = [self latestVersionWithConfig:infoProtocol];
        
        if([infoProtocol respondsToSelector:@selector(isReadonly)]) {
            self.isReadonly = [[infoProtocol performSelector:@selector(isReadonly)] boolValue];
        }
        
        if([infoProtocol respondsToSelector:@selector(isWALModeOn)]) {
            self.isWALModeOn = [[infoProtocol performSelector:@selector(isWALModeOn)] boolValue];
        }
        
        self.migrationAction = [self generateMigrationWithConfig:infoProtocol];
    }
    
    return self;
}

#pragma mark - Migration Action
-(NSInteger)latestVersionWithConfig:(id<BNCSQLiteDatabaseInfoProtocol>)infoProtocol {
    NSInteger schemaVersion = kBNCSQLiteInitVersion;
    
    if(![infoProtocol respondsToSelector:@selector(databaseMigrator)]) {
        // Don't Need Migrator
        return schemaVersion;
    }
    
    id<BNCSQLiteMigratorProtocol> migrator = nil;
    
    migrator = [infoProtocol performSelector:@selector(databaseMigrator)];
    
    NSArray *versionList = [migrator migrationVersionList];
    
    if (versionList.count > 0) {
       schemaVersion = [[versionList lastObject] integerValue];
    }
    
    return schemaVersion;
}

-(MigrationBlock)generateMigrationWithConfig:(id<BNCSQLiteDatabaseInfoProtocol>)infoProtocol {
    
    if(![infoProtocol respondsToSelector:@selector(databaseMigrator)]) {
        // Don't Need Migrator
        return nil;
    }
    
    id<BNCSQLiteMigratorProtocol> migrator = nil;
    
    migrator = [infoProtocol performSelector:@selector(databaseMigrator)];
    
    
    if (![migrator respondsToSelector:@selector(migrationStepDictionary)]) {
        // Don't Need Migrator
        return nil;
    }
    
    if (![migrator respondsToSelector:@selector(migrationVersionList)]) {
        // Don't Need Migrator
        return nil;
    }
    
    NSArray *versionList = [migrator migrationVersionList];
    NSDictionary *stepDictionary = [migrator migrationStepDictionary];
    
    MigrationBlock action = ^(BNCSQLiteDatabase *dbConnct) {
        // Do Version Migration
        BOOL shouldMigration = NO;
        
        for (NSNumber *version in versionList) {
            if (shouldMigration) {
                id<BNCSQLiteMigrationStepProtocol> step = [stepDictionary objectForKey:version];
                
                if (![step goUpWithAction:dbConnct]) {
                    break;
                }
                
                [dbConnct updateSchemaVersion:[version integerValue]];
            }
            
            if ([version integerValue] == [dbConnct currentVersion]) {
                shouldMigration = YES;
            }
        }
    };
    
    return action;
}

@end
