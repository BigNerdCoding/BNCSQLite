//
//  BNCSQLiteMigrationStepProtocol.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCSQLiteDatabase.h"

@protocol BNCSQLiteMigrationStepProtocol <NSObject>

@required

/**
 go upper version

 You implement this method to make migration forward
 
 @param dbConnect BNCSQLiteDataBase instance
 @return NO if migration up fails
 */
- (BOOL)goUpWithQueryCommand:(BNCSQLiteDatabase *)dbConnect;

@end
