# BNCSQLite

A Objective-C Wrapper Around SQLite. Inspired by [CTPersistance](https://github.com/casatwy/CTPersistance).

## Installing

BNCSQLite supports multiple methods for installing the library in a project

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like BNCSQLite in your projects. You can install it with the following command:

```
$ gem install cocoapods
```

#### Podfile

To integrate BNCSQLite into your Xcode project using CocoaPods, specify it in your Podfile:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
    pod 'BNCSQLite', '~> 1.3.6'
end
```

Then, run the following command:

```
$ pod install
```

### Installation with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```
$ brew update
$ brew install carthage
```

To integrate BNCSQLite into your Xcode project using Carthage, specify it in your Cartfile:

```
github "BigNerdCoding/BNCSQLite" ~> 1.1.0
```

Run carthage to build the framework and drag the built BNCSQLite.framework into your Xcode project.

## 使用说明 
### 持久化文件声明

首先，在正式创建具体的数据表之前，我们需要新建持久化文件。

```Objective-C
// BNCSQLiteTestDatabase.h
#import <Foundation/Foundation.h>
#import <BNCSQLite/BNCSQLiteDatabaseInfoProtocol.h>

@interface BNCSQLiteTestDatabase : NSObject <BNCSQLiteDatabaseInfoProtocol>

@end


// BNCSQLiteTestDatabase.m
#import "BNCSQLiteTestDatabase.h"

@implementation BNCSQLiteTestDatabase

#pragma mark - BNCSQLiteDatabaseInfoProtocol
- (NSString *)databaseFilePath {
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"BNCSQLiteORMTest.sqlite"];
}

@end
```

此处，我们新建了一个遵循 *BNCSQLiteDatabaseInfoProtocol* 协议的 *BNCSQLiteTestDatabase* 类，该类表示一个持久化文件。其实现的 *databaseFilePath* 方法指明了持久化文件的路径。如果需要创建内存数据库则在上面 *databaseFilePath* 中返回 *kBNCSQLiteMemoryModePath* 。

### 结构化数据声明和定义

此处，我们根据业务需求实现相关的结构化数据。需要注意的是，为了后面通过 *BNCSQLiteTable* 中的 API 进行数据库操作，免除手动编写 SQL 语句的枯燥工作。这里所有的结构化数据都必须有一个 *NSNumber* 类型的属性，该属性的代表数据库对应表中自增的主键字段。

```Objective-C
#import <Foundation/Foundation.h>
#import <BNCSQLite/BNCSQLiteRecord.h>

@interface BNCSQLiteTestRecord : BNCSQLiteRecord

@property(nonatomic, strong) NSNumber *rowID;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) BOOL  isCelebrity;
@property(nonatomic, strong) NSData *bolbData;
@property(nonatomic, assign) double progress;
@property(nonatomic, strong) NSString *nilText;
@property(nonatomic, strong) NSString *defaultText;
@property(nonatomic, assign) NSInteger defaultInt;
@property(nonatomic, assign) double defaultReal;
@property(nonatomic, assign) long long timeStamp;

@end

```

### 数据表声明

当定义好业务需求的结构化数据模型之后，我们需要定义一个与其相对应的数据库表结构。后续我们的数据库操作均基于该类实现。

```Objective-C
// BNCSQLiteTestTable.h
#import <Foundation/Foundation.h>
#import <BNCSQLite/BNCSQLiteTable.h>

@interface BNCSQLiteTestTable : BNCSQLiteTable

@end

// BNCSQLiteTestTable.m
#import "BNCSQLiteTestTable.h"
#import "BNCSQLiteTestRecord.h"
#import "BNCSQLiteTestDatabase.h"
#import <BNCSQLite/BNCSQLiteTableColumn.h>
#import <BNCSQLite/BNCSQLiteTableColumnIndex.h>

@implementation BNCSQLiteTestTable

#pragma mark - BNCSQLiteTableProtocol
- (id<BNCSQLiteDatabaseInfoProtocol>)databaseInfo  {
    return [[BNCSQLiteTestDatabase alloc] init];
}

- (NSString *)tableName {
    return @"test_table";
}

- (NSArray< id<BNCSQLiteTableColumnProtocol> > *)columnInfo {
    BNCSQLiteTableColumn *column = [BNCSQLiteTableColumn primaryRowIDColWithName:@"rowID"];

    BNCSQLiteTableColumn *column2 = [BNCSQLiteTableColumn notNullColWithName:@"name" type:BNCSQLiteTableColumnTypeText];
    BNCSQLiteTableColumn *column3 = [BNCSQLiteTableColumn notNullColWithName:@"age" type:BNCSQLiteTableColumnTypeInt];

    BNCSQLiteTableColumn *column4 = [BNCSQLiteTableColumn intColWithName:@"isCelebrity"];

    BNCSQLiteTableColumn *column5 = [BNCSQLiteTableColumn binaryColWithName:@"bolbData"];
    BNCSQLiteTableColumn *column6 = [BNCSQLiteTableColumn realColName:@"progress"];
    BNCSQLiteTableColumn *column7 = [BNCSQLiteTableColumn textColName:@"nilText"];

    BNCSQLiteTableColumn *column8 = [BNCSQLiteTableColumn textColName:@"defaultText" constraint:^(BNCSQLiteTableColumn *column) {
        [column settingDefaultValueConstraint:@" '' "];
    }];

    BNCSQLiteTableColumn *column9 = [BNCSQLiteTableColumn intColWithName:@"defaultInt" constraint:^(BNCSQLiteTableColumn *column) {
        [column settingDefaultValueConstraint:@" 0 "];
    }];

    BNCSQLiteTableColumn *column10 = [BNCSQLiteTableColumn realColName:@"defaultReal" constraint:^(BNCSQLiteTableColumn *column) {
        [column settingDefaultValueConstraint:@" 0.0 "];
    }];

    BNCSQLiteTableColumn *column11 = [BNCSQLiteTableColumn initUniqueColWithName:@"timeStamp" type:BNCSQLiteTableColumnTypeInt];

    return @[column, column2, column3, column4, column5, column6, column7, column8, column9, column10, column11];
}

- (Class)recordClass {
    return [BNCSQLiteTestRecord class];
}

- (NSString *)primaryKeyName {
    return @"rowID";
}

- (NSArray< id<BNCSQLiteTableColumnIndexProtocol> > *)indexList {
    BNCSQLiteTableColumnIndex *index = [[BNCSQLiteTableColumnIndex alloc] initWithIndexName:@"index_test" fields:@[@"age",@"timeStamp"]];

    return @[index];
}

@end
```

在 *BNCSQLiteTestTable.m* 文件中，我们实现了 *BNCSQLiteTableProtocol* 协议中的相关方法。其中 *databaseInfo* 函数表明了该数据表属于哪一个数据库，*tableName* 函数返回值是该数据表的表名，*columnInfo* 返回值则是该表所对应的列以及其数据类型和相关约束（与 *BNCSQLiteTestRecord* 的属性相对应）、*recordClass* 函数则表名了该数据表对应的结构化数据类型，*primaryKeyName* 返回值则表示该数据表对应的自增主键名、*indexList* 则是该数据表对应的索引信息。

### CRUD 操作

相关的数据表和结构化数据模型建好之后，下面就是我们常用的 CRUD 操作了。

#### 新增数据库记录：

```Objective-C
BNCSQLiteTestTable *table = [[BNCSQLiteTestTable alloc] init];
// 新增一条记录
NSError *error = nil;

BNCSQLiteTestRecord *record = [[BNCSQLiteTestRecord alloc] init];
record.name = @"";
record.age = 1;

record.timeStamp = 1000;
BOOL isSuccess = [table insertRecord:record error:&error];

// 新增一组记录
NSMutableArray *arr = [NSMutableArray array];

for (NSInteger index = 0; index < 10; index++) {
    BNCSQLiteTestRecord *record = [[BNCSQLiteTestRecord alloc] init];
    record.name = [NSString stringWithFormat:@"testName_%ld",(long)index];
    record.age = index;

    record.timeStamp = 1000;
    [arr addObject:record];
}

isSuccess = [table insertRecordList:arr error:&error];
```

#### 查询数据库记录

无条件查询：

```Objective-C
BNCSQLiteTestTable *table = [[BNCSQLiteTestTable alloc] init];

// 查询全部记录
NSError *error = nil;

NSArray *results = [table findAllWithError:&error];

// 查询全部记录但是按照某列排序
results = [table findAllWithOrder:@"timeStamp desc" error:&error];

// 查询最近一条记录
BNCSQLiteTestRecord *record = [table findLatestRecordWithError:&error];

// 查询最近几条记录
results = [table findRecordWithLimit:11 error:&error];
```

单个条件查询：

```Objective-C

// 主键查询
BNCSQLiteTestTable *table = [[BNCSQLiteTestTable alloc] init];
NSError *error = nil;

BNCSQLiteTestRecord *record = [table findWithPrimaryKey:@(100) error:&error];

// 单条件等值查询
NSArray *result = [table findAllWithColumn:@"age" value:@(20) error:&error];

// 单条件等值查询 & 排序
result = [table findAllWithColumn:@"progress" value:@(0.5) orderBy:@"timeStamp desc" error:&error];

// 单条件 IN 查询
NSArray *result = [table findAllWithColumn:@"age" inValueList:@[@(1),@(3),@(5),@(7),@(9),@(11)] error:&error];
```

多个条件查询：

```Objective-C
BNCSQLiteTestTable *table = [[BNCSQLiteTestTable alloc] init];
NSError *error = nil;

// 多条件查询
NSArray *results = [_table findAllWithCondition:@"progress = :progress AND timeStamp < :timeStamp" params:@{@"timeStamp":@(1005),@"progress":@"0.5"} error:&error];

// 多条件查询 & 排序
results = [_table findAllWithCondition:@"progress = :progress AND timeStamp < :endTimeStamp" params:@{@"endTimeStamp":@(1005),@"progress":@"0.5"} orderBy:@"age desc" error:&error];
```

无需 *bind* 的条件查询：

上面的但条件和多条件查询操作中，为了得到最终的 *where* 子句，我们都需要执行形如 *sqlite3_bind_int64* 这类操作将对应的 value 值绑定到特定位置上。如果我们已经明确知道 *where* 子句条件的话，则可以调用下列方法避免不必要的 *bind* 过程：

```Objective-C

BNCSQLiteTestTable *table = [[BNCSQLiteTestTable alloc] init];
NSError *error = nil;

// 无排序 
NSArray *result = [table findAllWithWhere:@"age = 20" error:&error];

// 排序
result  = [table findAllWithWhere:@"age > 4"  orderBy:@"age DESC" error:&error]; 

// limit
result  = [table findRecordWithWhere:@"age > 4" limit:1 error:&error];

// orderBy & limit
result  = [table findRecordWithWhere:@"age > 4"  orderBy:@"age DESC" limit:1 error:&error];
```

### 数据库升级

在日常使用中我们总会遇到数据库升级操作的需求，而 BNCSQLite 中数据库升级操作如下：

例如：*BNCSQLiteMigrationTestRecord* 及其对应的 *BNCSQLiteMigrationTestTable* 总过升级过二次，从默认的版本 1 升级到了版本 2 然后再升级到版本 3。

```Objective-C
// 第一版
@interface BNCSQLiteMigrationTestRecord : BNCSQLiteRecord

@property(nonatomic, strong) NSNumber *rowID;
@property(nonatomic, strong) NSString *version1;

@end

// 第二版，相比第一版增加了 version2 字段
@interface BNCSQLiteMigrationTestRecord : BNCSQLiteRecord

@property(nonatomic, strong) NSNumber *rowID;
@property(nonatomic, strong) NSString *version1;
@property(nonatomic, strong) NSString *version2;

@end

// 第三版，相比第二版增加了 version3 字段
@interface BNCSQLiteMigrationTestRecord : BNCSQLiteRecord

@property(nonatomic, strong) NSNumber *rowID;
@property(nonatomic, strong) NSString *version1;
@property(nonatomic, strong) NSString *version2;
@property(nonatomic, strong) NSString *version3;

@end
```

那么我们需要定义该两次升级对应的步骤：

```Objective-C

// 第二版升级操作
#import <Foundation/Foundation.h>
#import <BNCSQLite/BNCSQLiteMigrationStepProtocol.h>

@interface BNCSQLiteMigrationTestStep2 : NSObject <BNCSQLiteMigrationStepProtocol>

@end

#import "BNCSQLiteMigrationTestStep2.h"
#import <BNCSQLite/NSString+BNCSQLiteSchema.h>
#import <BNCSQLite/BNCSQLiteTableColumn.h>

@implementation BNCSQLiteMigrationTestStep2

#pragma mark - BNCSQLiteMigrationStepProtocol

- (BOOL)goUpWithAction:(BNCSQLiteDatabase *)dbConnect {
    NSError *error = nil;

    BNCSQLiteTableColumn *column2 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version2" type:BNCSQLiteTableColumnTypeText constraint:nil];

    NSString *sql = [NSString addColumn:column2 tableName:@"migration_test_table"];

    return [dbConnect executeSQL:sql bind:nil rowHandle:nil error:&error];
}

@end


// 第三次升级操作
#import <Foundation/Foundation.h>
#import <BNCSQLite/BNCSQLiteMigrationStepProtocol.h>

@interface BNCSQLiteMigrationTestStep3 : NSObject <BNCSQLiteMigrationStepProtocol>

@end

#import "BNCSQLiteMigrationTestStep2.h"
#import <BNCSQLite/NSString+BNCSQLiteSchema.h>
#import <BNCSQLite/BNCSQLiteTableColumn.h>

@implementation BNCSQLiteMigrationTestStep3

#pragma mark - BNCSQLiteMigrationStepProtocol

- (BOOL)goUpWithAction:(BNCSQLiteDatabase *)dbConnect {
    NSError *error = nil;

    BNCSQLiteTableColumn *column3 = [[BNCSQLiteTableColumn alloc] initWithColName:@"version3" type:BNCSQLiteTableColumnTypeText constraint:nil];

    NSString *sql = [NSString addColumn:column3 tableName:@"migration_test_table"];

    return [dbConnect executeSQL:sql bind:nil rowHandle:nil error:&error];
}

@end
```

定义好每次升级对应的操作后，接下来我们需要在对应持久化类中配置这些升级步骤：

```Objective-C

// BNCSQLiteMigratorTest.h

#import <Foundation/Foundation.h>
#import <BNCSQLite/BNCSQLiteMigratorProtocol.h>

@interface BNCSQLiteMigratorTest : NSObject <BNCSQLiteMigratorProtocol>

@end

// BNCSQLiteMigratorTest.m
#import "BNCSQLiteMigratorTest.h"
#import "BNCSQLiteMigrationTestStep2.h"
#import "BNCSQLiteMigrationTestStep3.h"

@implementation BNCSQLiteMigratorTest

#pragma mark - BNCSQLiteMigratorProtocol
- (NSArray<NSNumber *> *)migrationVersionList {
    return @[@(kBNCSQLiteInitVersion),@(2),@(3)];
}

- (NSDictionary<NSNumber *,id<BNCSQLiteMigrationStepProtocol> > *)migrationStepDictionary {
    return @{@(2):[[BNCSQLiteMigrationTestStep2 alloc] init],
    @(3):[[BNCSQLiteMigrationTestStep3 alloc] init]};
}

@end


//BNCSQLiteTestDatabase.m
#import "BNCSQLiteTestDatabase.h"
#import "BNCSQLiteMigratorTest.h"

@implementation BNCSQLiteTestDatabase

#pragma mark - BNCSQLiteDatabaseInfoProtocol
- (NSString *)databaseFilePath {
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"BNCSQLiteMigrationTest.sqlite"];

    return filePath;
}

- (id<BNCSQLiteMigratorProtocol>)databaseMigrator {
    return [[BNCSQLiteMigratorTest alloc] init];
}

@end
```

上面代码中，我们新建了一个升级执行管理类 *BNCSQLiteMigratorTest* 在里面我们配置了数据库的所有版本历史 *migrationVersionList* 以及每个版本对应的升级操作步骤 *migrationStepDictionary* 。最后我们在数据库配置类中的 *databaseMigrator* 协议方法里返回前面管理类的实例对线。

注意：数据库默认版本为 *kBNCSQLiteInitVersion* 也就是 1 ，如果是新建数据库的话会使用版本列表中最新的版本号并且不会执行数据库升级操作。只有在本地已经存在老版本数据库文件时才会执行数据库升级操作。

### 更多操作

CRUD 操作涉及的接口非常多，详情可以去查看代码里面的 API 注释。另外该部分代码配套了单元测试，使用者也可以参照单元测试里面的代码了解具体的 API 使用。

## License

BNCSQLite is released under the MIT license. See [LICENSE](https://github.com/BigNerdCoding/BNCSQLite/blob/master/LICENSE) for details.
