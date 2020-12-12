//
//  BNCSQLiteTable+Insert.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/3.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteTable.h"
#import "BNCSQLiteRecordProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteTable (Insert)

/**
 insert a record

 @param record the record to insert
 @param error the error if insert fails
 @return return YES if success
 */
- (BOOL)insertRecord:(NSObject<BNCSQLiteRecordProtocol> *)record
               error:(NSError *__nullable __autoreleasing *)error;

/**
 insert a list of record

 @param recordList the list of record to insert
 @param error the error if insert fails
 @return return YES if success
 */
- (BOOL)insertRecordList:(NSArray<NSObject<BNCSQLiteRecordProtocol> * > *)recordList
                   error:(NSError *__nullable __autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
