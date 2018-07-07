//
//  BNCSQLiteORMFindWithMulitConditionUnitTest.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/6.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLiteTestTable.h"
#import "BNCSQLiteTestRecord.h"
#import "BNCSQLiteTable+Insert.h"
#import "BNCSQLiteTable+Find.h"
#import "BNCSQLiteTable+Delete.h"

@interface BNCSQLiteORMFindWithMulitConditionUnitTest : XCTestCase

@property(nonatomic,strong) BNCSQLiteTestTable *table;

@end

@implementation BNCSQLiteORMFindWithMulitConditionUnitTest

- (void)setUp {
    [super setUp];
    
    _table = [[BNCSQLiteTestTable alloc] init];
    [self generateTestData];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    BOOL isSuccess = [_table truncate];
    XCTAssertTrue(isSuccess);
}

- (void)testFindAllWithCondition {
    NSError *error = nil;
    
    NSArray *results = [_table findAllWithCondition:@"progress = :progress AND timeStamp < :timeStamp" params:@{@"timeStamp":@(1005),@"progress":@"0.5"} error:&error];
    
    XCTAssertEqual(results.count, 3);
}


- (void)testFindAllWithCondition_order {
    NSError *error = nil;
    
    NSArray *results = [_table findAllWithCondition:@"progress = :progress AND timeStamp < :timeStamp" params:@{@"timeStamp":@(1005),@"progress":@"0.5"} orderBy:@"age desc" error:&error];
    
    XCTAssertEqual(results.count, 3);
    
    BNCSQLiteTestRecord *record = [results firstObject];
    NSInteger age = record.age;
    for (NSInteger index = 1; index < results.count; index++) {
        record = [results objectAtIndex:index];
        XCTAssert(age >= record.age);
        age = record.age;
    }
}


- (void)testFindRecordWithCondition_limit {
    NSError *error = nil;
    
    NSArray *results = [_table findRecordWithCondition:@"progress = :progress AND timeStamp < :timeStamp" params:@{@"timeStamp":@(1005),@"progress":@"0.5"} limit:2 error:&error];
    
    XCTAssertEqual(results.count, 2);
}


- (void)testFindRecordWithCondition_order_limit {
    NSError *error = nil;
    
    NSArray *results = [_table findRecordWithCondition:@"progress = :progress AND timeStamp < :timeStamp" params:@{@"timeStamp":@(1005),@"progress":@"0.5"} orderBy:@"age desc" limit:5 error:&error];
    XCTAssertEqual(results.count, 3);
    
    BNCSQLiteTestRecord *record = [results firstObject];
    NSInteger age = record.age;
    for (NSInteger index = 1; index < results.count; index++) {
        record = [results objectAtIndex:index];
        XCTAssert(age >= record.age);
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
