//
//  BNCSQLiteORMFindWithSingleConditionUnitTest.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/5.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLiteTestTable.h"
#import "BNCSQLiteTestRecord.h"
#import "BNCSQLiteTable+Insert.h"
#import "BNCSQLiteTable+Find.h"
#import "BNCSQLiteTable+Delete.h"

@interface BNCSQLiteORMFindWithSingleConditionUnitTest : XCTestCase

@property(nonatomic,strong) BNCSQLiteTestTable *table;

@end

@implementation BNCSQLiteORMFindWithSingleConditionUnitTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _table = [[BNCSQLiteTestTable alloc] init];
    [self generateTestData];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    BOOL isSuccess = [_table truncate];
    XCTAssertTrue(isSuccess);
}

- (void)testFindWithPrimaryKey {
    NSError *error = nil;
    
    BNCSQLiteTestRecord *record = [_table findWithPrimaryKey:@(100) error:&error];
    
    XCTAssertNil(error);
    XCTAssertNil(record);
    
    record = [_table findWithPrimaryKey:@(1) error:&error];
    
    XCTAssertNil(error);
    XCTAssertNotNil(record);
}

- (void)testFindWithUniqueColumn {
    NSError *error = nil;
    
    BNCSQLiteTestRecord *record = [_table findWithUniqueColumn:@"timeStamp" value:@(100) error:&error];
    
    XCTAssertNil(error);
    XCTAssertNil(record);
    
    record = [_table findWithUniqueColumn:@"timeStamp" value:@(1001) error:&error];
    
    XCTAssertNil(error);
    XCTAssertNotNil(record);
}

- (void)testFindAllWithColumn {
    NSError *error = nil;
    
    NSArray *result = [_table findAllWithColumn:@"age" value:@(20) error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 0);
    
    result = [_table findAllWithColumn:@"progress" value:@(0.5) error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 5);
}


- (void)testFindAllWithColumn_order {
    NSError *error = nil;
    
    NSArray *result = [_table findAllWithColumn:@"progress" value:@(0.5) orderBy:@"" error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 5);
    
    BNCSQLiteTestRecord *record = [result firstObject];
    NSInteger timeStamp = record.timeStamp;
    for (NSInteger index = 1; index < result.count; index++) {
        record = [result objectAtIndex:index];
        XCTAssert(timeStamp <= record.timeStamp);
        timeStamp = record.timeStamp;
    }
    
    result = [_table findAllWithColumn:@"progress" value:@(0.5) orderBy:@"timeStamp desc" error:&error];
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 5);
    
    record = [result firstObject];
    timeStamp = record.timeStamp;
    for (NSInteger index = 1; index < result.count; index++) {
        record = [result objectAtIndex:index];
        XCTAssert(timeStamp >= record.timeStamp);
        timeStamp = record.timeStamp;
    }
}

- (void)testFindAllWithColumn_inValueList {
    NSError *error = nil;
    
    NSArray *result = [_table findAllWithColumn:@"age" inValueList:@[@(1),@(3),@(5),@(7),@(9),@(11)] error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 5);
}

- (void)testFindAllWithColumn_inValueList_order {
    NSError *error = nil;
    
    NSArray *result = [_table findAllWithColumn:@"age" inValueList:@[@(1),@(3),@(5),@(7),@(9),@(11)] orderBy:@"age" error:&error];
    
    BNCSQLiteTestRecord *record = [result firstObject];
    NSInteger age = record.age;
    for (NSInteger index = 1; index < result.count; index++) {
        record = [result objectAtIndex:index];
        XCTAssert(age <= record.age);
        age = record.age;
    }
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 5);
}

- (void)testFindRecordWithColumn_limit {
    NSError *error = nil;
    
    NSArray *result = [_table findRecordWithColumn:@"progress" value:@(0.5) limit:3 error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 3);
    
    result = [_table findRecordWithColumn:@"progressxxx" value:@(0.5) limit:3 error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertEqual(result.count, 0);
}

- (void)testFindRecordWithColumn_limit_order {
    NSError *error = nil;
    
    NSArray *result = [_table findRecordWithColumn:@"progress" value:@(0.5) orderBy:@"age" limit:6 error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 5);
    
    BNCSQLiteTestRecord *record = [result firstObject];
    NSInteger age = record.age;
    for (NSInteger index = 1; index < result.count; index++) {
        record = [result objectAtIndex:index];
        XCTAssert(age <= record.age);
        age = record.age;
    }
}

- (void)generateTestData {
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    
    for (NSInteger index = 0; index < 10; index++) {
        BNCSQLiteTestRecord *record = [[BNCSQLiteTestRecord alloc] init];
        record.name = [NSString stringWithFormat:@"testName_%ld",(long)index];
        record.age = index;
        
        if (index % 2 == 0) {
            record.progress = 0.5;
        } else {
            record.progress = 0.3;
        }
        
        record.timeStamp = 1000 + index;
        [arr addObject:record];
    }
    
    NSError *error = nil;
    
    BOOL isSuccess =  [_table insertRecordList:arr error:&error];
    
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
}

@end
