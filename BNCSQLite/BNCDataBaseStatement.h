//
//  BNCDataBaseStatement.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNCDataBase;

@interface BNCDataBaseStatement : NSObject

- (instancetype)initWithSQLString:(NSString *)sqlString
                         database:(BNCDataBase *)database
                            error:(NSError *__autoreleasing *)error;

- (void)finalizeStatement;

- (NSInteger)stepStatament;

@end
