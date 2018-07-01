//
//  BNCDataBase.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/6/29.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class BNCDataBaseStatement;

typedef void(^BindBlock)(BNCDataBaseStatement *);
typedef void(^RowHandleBlock)(BNCDataBaseStatement *, NSInteger);

extern NSString * const kBNCSQLiteErrorDomain;

@interface BNCDataBase : NSObject

@property (nonatomic, unsafe_unretained, readonly) sqlite3 *database;

- (instancetype)initWithPath:(NSString *)filePath error:(NSError *__autoreleasing *)error;

- (void)closeDatabase;

- (BOOL)executeSQL:(NSString *)sqlString bind:(BindBlock)bind rowHandle:(RowHandleBlock)rowHandle error:(NSError *__autoreleasing *)error;

@end
