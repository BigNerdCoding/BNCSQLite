//
//  BNCSQLiteDatabaseStatement+Take.h
//  BNCSQLite
//
//  Created by Jax Wu on 2018/7/1.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import "BNCSQLiteDatabaseStatement.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNCSQLiteDatabaseStatement (Take)

#pragma mark - Take With Position
/**
 get the all value for the statement

 @return all value , format: @{columnName:value}
 */
- (NSDictionary *)takeAllColumn;

/**
 get the Int value for the indicated column

 @param iValuePosition position of column
 @return Int value for column
 */
- (int64_t)takeIntColumnAt:(int)iValuePosition;

/**
 get the Double value for the indicated column

 @param dValuePosition position of column
 @return Double value for column
 */
- (double)takeDoubleColumnAt:(int)dValuePosition;

/**
 get the String value for the indicated column

 @param tValuePosition position of column
 @return String value for column
 */
- (NSString * _Nullable)takeTextColumnAt:(int)tValuePosition;

/**
 get the Binary value for the indicated column

 @param bValuePosition position of column
 @return Binary value for column
 */
- (NSData * _Nullable)takeBinaryColumnAt:(int)bValuePosition;

@end

NS_ASSUME_NONNULL_END
