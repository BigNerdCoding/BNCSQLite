//
//  BNCSQLiteMigratorProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteMigrationStepProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BNCSQLiteMigratorProtocol <NSObject>

@required
/**
 *  the order of migration
 *
 *  @return return the order of migration
 */
- (NSArray<NSNumber *> *)migrationVersionList;


/**
 the dictionary contains step objects which keyed by version number

 @return return step dictionary
 */
- (NSDictionary<NSNumber *,id<BNCSQLiteMigrationStepProtocol> > *)migrationStepDictionary;

@end

NS_ASSUME_NONNULL_END
