//
//  BNCSQLiteDataBaseStatement+Take.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "BNCSQLiteDataBaseStatement+Take.h"

@implementation BNCSQLiteDataBaseStatement (Take)

- (NSDictionary *)takeAllColumn {
    NSInteger columnConut = [self columnCount];
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:columnConut];
    for (int index = 0; index < columnConut; index++) {
        const char *name = sqlite3_column_name(self.statement, index);
        
        NSString *columnName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        int type = sqlite3_column_type(self.statement, index);
        
        switch (type) {
            case SQLITE_INTEGER:
            {
                int64_t value = sqlite3_column_int64(self.statement, index);
                [result setObject:@(value) forKey:columnName];
                break;
            }
            case SQLITE_FLOAT:
            {
                double value = sqlite3_column_double(self.statement, index);
                [result setObject:@(value) forKey:columnName];
                break;
            }
            case SQLITE_TEXT:
            {
                const char *value = (const char*)sqlite3_column_text(self.statement, index);
                [result setObject:[NSString stringWithCString:value encoding:NSUTF8StringEncoding] forKey:columnName];
                break;
            }
                
            case SQLITE_BLOB:
            {
                int bytes = sqlite3_column_bytes(self.statement, index);
                if (bytes > 0) {
                    const void *blob = sqlite3_column_blob(self.statement, index);
                    if (blob != NULL) {
                        [result setObject:[NSData dataWithBytes:blob length:bytes] forKey:columnName];
                    }
                }
                break;
            }
                
            default:
                // Do Nothing
                break;
        }

    }
    
    return result;
}

- (int64_t)takeIntColumn:(int)iValuePosition {
    return sqlite3_column_int64(self.statement, iValuePosition);
}

- (double)takeDoubleColumn:(int)dValuePosition {
    return sqlite3_column_double(self.statement, dValuePosition);
}

- (NSString *)takeTextColumn:(int)tValuePosition {
    const char *textValue = (const char*)sqlite3_column_text(self.statement, tValuePosition);
    
    return [[NSString alloc] initWithCString:textValue encoding:NSUTF8StringEncoding];
}

- (NSData *)takeBinaryColumn:(int)bValuePosition {
    NSData *binaryResult = nil;
    
    int bytes = sqlite3_column_bytes(self.statement, bValuePosition);
    if (bytes > 0) {
        const void *blob = sqlite3_column_blob(self.statement, bValuePosition);
        
        if (blob != NULL) {
            binaryResult = [NSData dataWithBytes:blob length:bytes];
        }
    }
    
    return binaryResult;
}

@end
