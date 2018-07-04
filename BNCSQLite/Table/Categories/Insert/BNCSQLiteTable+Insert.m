//
//  BNCSQLiteTable+Insert.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable+Insert.h"

@implementation BNCSQLiteTable (Insert)

- (BOOL)insertRecord:(id<BNCSQLiteRecordProtocol>)record error:(NSError *__autoreleasing *)error {
    
    return YES;
}

- (BOOL)insertRecordList:(NSArray<id<BNCSQLiteRecordProtocol> > *)recordList
               error:(NSError *__autoreleasing *)error {
    
    __block BOOL isSuccess = YES;
    
    [self.dbConnect executeSQLWithTransaction:^{

        for (id<BNCSQLiteRecordProtocol> record in recordList) {
            isSuccess = [self insertRecord:record error:error];
            
            if (!isSuccess) {
                break;
            }
        }
        
        return isSuccess;
        
    } lockType:BNCSQLiteTransactionLockTypeDeferred];
     
    
    return isSuccess;
}

@end
