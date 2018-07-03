//
//  NSString+BNCSQLiteSchema.m
//  BNCSQLite
//
//  Created by Karsa Wu on 2018/7/2.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import "NSString+BNCSQLiteSchema.h"

@implementation NSString (BNCSQLiteSchema)

+ (instancetype)createTable:(NSString *)tableName withColumns:(NSArray<id<BNCSQLiteTableColumnProtocol> > *)columns {
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ", tableName];
    
    NSMutableArray *descriptionArr = [NSMutableArray arrayWithCapacity:[columns count]];
    
    for (id<BNCSQLiteTableColumnProtocol> column in columns) {
        NSString *columnDescription = [NSString compileColumnDescriptionAtTableCreate:column];
        [descriptionArr addObject:columnDescription];
    }
    
    NSString *columnDescriptions = [descriptionArr componentsJoinedByString:@","];
    
    return [sql stringByAppendingString:[NSString stringWithFormat:@" (%@) ;",columnDescriptions]];
}

+ (instancetype)dropTable:(NSString *)tableName {
    return [NSString stringWithFormat:@"DROP TABLE IF EXISTS '%@' ;", tableName];
}

+ (instancetype)addColumn:(id<BNCSQLiteTableColumnProtocol>)column tableName:(NSString *)tableName {
    NSString *columnDescription = [NSString compileColumnDescriptionAtTableCreate:column];
    
    [columnDescription stringByReplacingOccurrencesOfString:[column columnName] withString:@""];
    
    return [NSString stringWithFormat:@"ALTER TABLE '%@' ADD COLUMN '%@' %@;", tableName, [column columnName],columnDescription];
}

+ (instancetype)addIndex:(id<BNCSQLiteTableColumnIndexProtocol>)tableIndex tableName:(NSString *)tableName {
    
    NSString *sqlString = @"";
    if (tableIndex.isUniqueIndex) {
        sqlString = [NSString stringWithFormat:@"CREATE UNIQUE INDEX IF NOT EXISTS '%@' ",tableIndex.indexName] ;
    } else {
        sqlString = [NSString stringWithFormat:@"CREATE INDEX IF NOT EXISTS '%@' ",tableIndex.indexName] ;
    }
    
    NSString *indexedColumnListString = [tableIndex.indexCloumnFields componentsJoinedByString:@","];
    
    return [NSString stringWithFormat:@"%@  ON '%@' (%@)",sqlString,tableName,indexedColumnListString];
}

+ (instancetype)dropIndex:(NSString *)indexName {
    return [NSString stringWithFormat:@"DROP INDEX IF EXISTS '%@'",indexName];
}

+ (instancetype)columnInfoWithTableName:(NSString *)tableName {
    return [NSString stringWithFormat:@"PRAGMA table_info(`%@`);", tableName];
}

#pragma mark - Helper
+ (instancetype)compileColumnDescriptionAtTableCreate:(id<BNCSQLiteTableColumnProtocol>)column {
    
    NSString *columnDescription = [NSString stringWithFormat:@" %@ ", [column columnName]];
    
    NSString *type  = @"";
    switch ([column columnType]) {
        case BNCSQLiteTableColumnTypeInt:
            type = @" INTEGER ";
            break;
        case BNCSQLiteTableColumnTypeReal:
            type = @" REAL ";
            break;
        case BNCSQLiteTableColumnTypeText:
            type = @" TEXT ";
            break;
        case BNCSQLiteTableColumnTypeBinary:
            type = @" BLOB ";
            break;
    }
    columnDescription = [columnDescription stringByAppendingString:type];
    
    if ([column isPrimarykey]) {
        columnDescription =  [columnDescription stringByAppendingString:@" PRIMARY KEY "];
    }
    
    if ([column isPrimarykey] && [column isAutoIncrement]) {
        columnDescription =  [columnDescription stringByAppendingString:@" AUTOINCREMENT "];
    }
    
    if (![column isNull]) {
        columnDescription =  [columnDescription stringByAppendingString:@" NOT NULL "];
    }
    
    if ([column defaultValue]  && ![[column defaultValue] isEqualToString:@""]) {
        columnDescription =  [columnDescription stringByAppendingString:[NSString stringWithFormat:@" DEFAULT %@ ",[column defaultValue] ]];
    }
    
    
    return columnDescription;
}

@end
