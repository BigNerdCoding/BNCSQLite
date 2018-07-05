//
//  BNCSQLiteTable+Insert.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/3.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteTable+Insert.h"
#import "BNCSQLiteDatabaseStatement+Bind.h"

@implementation BNCSQLiteTable (Insert)

- (BOOL)insertRecord:(NSObject<BNCSQLiteRecordProtocol> *)record
               error:(NSError *__autoreleasing *)error {

    NSDictionary *recordDic = [record dictionaryRepresentationWithTable:self];
    
    NSString *insertSQL = [self generateInsertSQLWithColumn:recordDic.allKeys];
    
    return [self.dbConnect executeSQL:insertSQL bind:^(BNCSQLiteDatabaseStatement *statement) {
        [recordDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *bindKey = [NSString stringWithFormat:@":%@",key];
            [statement bindColumn:bindKey withValue:obj];
        }];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowNum) {
        [record setValue:@([self.dbConnect latestInsertRowID]) forKey:self.primaryKeyName];
    } error:error];
}

- (BOOL)insertRecordList:(NSArray<NSObject <BNCSQLiteRecordProtocol> * > *)recordList
                   error:(NSError *__autoreleasing *)error {
    
    __block BOOL isSuccess = YES;
    
    return [self.dbConnect executeSQLWithTransaction:^{

        for (id<BNCSQLiteRecordProtocol> record in recordList) {
            isSuccess = [self insertRecord:record error:error];
            
            if (!isSuccess) {
                break;
            }
        }
        
        return isSuccess;
        
    } lockType:BNCSQLiteTransactionLockTypeDeferred];
}

- (NSString *)generateInsertSQLWithColumn:(NSArray<NSString *> *)columnNames {
  
    
    NSMutableArray *insertColumns = [NSMutableArray array];
    NSMutableArray *insertValues = [NSMutableArray array];
    for (NSString *columnName in columnNames) {
        [insertColumns addObject:columnName];
        [insertValues addObject:[NSString stringWithFormat:@":%@",columnName]];
    }
    
    NSString *insertColumnSQL = [insertColumns componentsJoinedByString:@","];
    NSString *insertValueSQL = [insertValues componentsJoinedByString:@","];
    
    return [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@) ;", self.tableName, insertColumnSQL, insertValueSQL];
}



@end
