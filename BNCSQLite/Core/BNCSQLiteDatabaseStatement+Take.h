//
//  BNCSQLiteDatabaseStatement+Take.h
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteDatabaseStatement.h"

@interface BNCSQLiteDatabaseStatement (Take)

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
- (int64_t)takeIntColumn:(int)iValuePosition;

/**
 get the Double value for the indicated column

 @param dValuePosition position of column
 @return Double value for column
 */
- (double)takeDoubleColumn:(int)dValuePosition;

/**
 get the String value for the indicated column

 @param tValuePosition position of column
 @return String value for column
 */
- (NSString *)takeTextColumn:(int)tValuePosition;

/**
 get the Binary value for the indicated column

 @param bValuePosition position of column
 @return Binary value for column
 */
- (NSData *)takeBinaryColumn:(int)bValuePosition;

@end
