//
//  BNCSQLiteDatabaseStatement+Bind.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/1.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteDatabaseStatement.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteDatabaseStatement (Bind)

#pragma mark - Bind With Position
/**
 Bind a null to the indicated parameter
 
 @param position null position of binding
 */
- (void)bindNullAt:(int)position;

/**
 Bind a int to the indicated parameter

 @param iValue Int64 to be bound
 @param position Int position of binding
 */
- (void)bindInteger:(int64_t)iValue atPosition:(int)position;

/**
 Bind a double to the indicated parameter

 @param dValue double to be bound
 @param position double position of binding
 */
- (void)bindDoubleValue:(double)dValue atPosition:(int)position;

/**
 Bind a string to the indicated parameter

 @param tValue string to be bound
 @param position string position of binding
 */
- (void)bindTextValue:(NSString *)tValue atPosition:(int)position;

/**
 Bind a binary to the indicated parameter

 @param bValue binary to be bound
 @param position binary position of binding
 */
- (void)bindBinaryValue:(NSData *)bValue atPosition:(int)position;

#pragma mark - Bind With ColumnName

/**
 Bind a null to the indicated parameter

 @param columnName column name of binding
 */
- (void)bindNullColumn:(NSString *)columnName;

/**
 Bind a int to the indicated parameter

 @param columnName column name of binding
 @param iValue int to be bound
 */
- (void)bindColumn:(NSString *)columnName withIntValue:(int64_t)iValue;

/**
 Bind a double to the indicated parameter

 @param columnName column name of binding
 @param dValue double to be bound
 */
- (void)bindColumn:(NSString *)columnName withDoubleValue:(double)dValue;

/**
 Bind a string to the indicated parameter

 @param columnName column name of binding
 @param tValue string to be bound
 */
- (void)bindColumn:(NSString *)columnName withTextValue:(NSString *)tValue;

/**
 Bind a binary to the indicated parameter

 @param columnName column name of binding
 @param bValue binary to be bound
 */
- (void)bindColumn:(NSString *)columnName withBinaryValue:(NSData *)bValue;

#pragma mark - Bind With id Type
/**
 Bind a `id` to the indicated parameter
 
 @param columnName columnName column name of binding
 @param bindValue `id` to be bound
 */
- (void)bindColumn:(NSString *)columnName withValue:(id)bindValue;

@end


NS_ASSUME_NONNULL_END
