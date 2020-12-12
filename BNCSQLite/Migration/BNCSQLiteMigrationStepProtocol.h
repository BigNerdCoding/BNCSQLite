//
//  BNCSQLiteMigrationStepProtocol.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/3.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteDatabase.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BNCSQLiteMigrationStepProtocol <NSObject>

@required

/**
 go upper version

 You implement this method to make migration forward
 
 @param dbConnect BNCSQLiteDataBase instance
 @return NO if migration up fails
 */
- (BOOL)goUpWithAction:(BNCSQLiteDatabase *)dbConnect;

@end

NS_ASSUME_NONNULL_END
