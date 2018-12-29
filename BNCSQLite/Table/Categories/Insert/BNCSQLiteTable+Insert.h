//
//  BNCSQLiteTable+Insert.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable.h"
#import "BNCSQLiteRecordProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteTable (Insert)

- (BOOL)insertRecord:(NSObject<BNCSQLiteRecordProtocol> *)record
               error:(NSError *__nullable __autoreleasing *)error;

- (BOOL)insertRecordList:(NSArray<NSObject<BNCSQLiteRecordProtocol> * > *)recordList
                   error:(NSError *__nullable __autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
