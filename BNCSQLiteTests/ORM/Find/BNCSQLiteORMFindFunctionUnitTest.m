//
//  BNCSQLiteORMFindGeneralUnitTest.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/5.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLiteTestTable.h"
#import "BNCSQLiteTestRecord.h"
#import "BNCSQLiteTable+Insert.h"
#import "BNCSQLiteTable+Function.h"
#import "BNCSQLiteTable+Delete.h"

@interface BNCSQLiteORMFindFunctionUnitTest : XCTestCase

@property(nonatomic,strong) BNCSQLiteTestTable *table;

@end

@implementation BNCSQLiteORMFindFunctionUnitTest

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


- (void)testCountTotalRecord {
    NSInteger count = [_table countTotalRecord];
    XCTAssert(count == 10);
}

- (void)testCountWithCondition {
    NSInteger count = [_table countWithCondition:@"age > 5"];
    XCTAssert(count == 4);
    
    
    count = [_table countWithCondition:@"age > 5 AND timeStamp < 1007"];
    XCTAssert(count == 1);
}

- (void)testCountWithCondition_params {
    NSInteger count = [_table countWithCondition:@"age > :age" params:@{@"age":@(5)}];
    XCTAssert(count == 4);
    
    
    count = [_table countWithCondition:@"age > :age AND timeStamp < :timeStamp" params:@{@"age":@(5),
                                                                                         @"timeStamp":@(1007)
                                                                                         }];
    XCTAssert(count == 1);
}

- (void)testMaxIntValue {
    NSInteger nValue = [_table maxIntValueOfColumn:@"age"];
    
    XCTAssert(nValue == 9);
}

- (void)testMaxIntValue_where {
    NSInteger nValue = [_table maxIntValueOfColumn:@"age" where:@""];
    
    XCTAssert(nValue == 9);
    
    nValue = [_table maxIntValueOfColumn:@"age" where:@"age < 9"];
    XCTAssert(nValue == 8);
    
    nValue = [_table maxIntValueOfColumn:@"age" where:@"age > 10"];
    XCTAssert(nValue == 0);
}

- (void)testMaxIntValue_where_params {
    NSInteger nValue = [_table maxIntValueOfColumn:@"age" where:@"age > :age" params:@{@"age":@(5)}];
    XCTAssert(nValue == 9);
}

- (void)testMaxDoubleValue {
    double dValue  = [_table maxDoubleValueOfColumn:@"progress"];
    
    XCTAssert(dValue == 0.9);
}

- (void)testMaxDoubleValue_where {
    double dValue = [_table maxDoubleValueOfColumn:@"progress" where:@""];
    
    XCTAssert(dValue == 0.9);
    
    dValue = [_table maxDoubleValueOfColumn:@"progress" where:@"age < 9"];
    XCTAssert(dValue == 0.8);
    
    dValue = [_table maxDoubleValueOfColumn:@"progress" where:@"age > 10"];
    XCTAssert(dValue == 0);
}

- (void)testMaxDoubleValue_where_params {
    double dValue = [_table maxDoubleValueOfColumn:@"progress" where:@"age > :age" params:@{@"age":@(5)}];
    XCTAssert(dValue == 0.9);
}

- (void)testMinIntValue {
    NSInteger nValue = [_table minIntValueOfColumn:@"age"];
    
    XCTAssert(nValue == 0);
}

- (void)testMinIntValue_where {
    NSInteger nValue = [_table minIntValueOfColumn:@"age" where:@""];
    
    XCTAssert(nValue == 0);
    
    nValue = [_table minIntValueOfColumn:@"age" where:@"age > 7"];
    XCTAssert(nValue == 8);
}

- (void)testMinIntValue_where_params {
    NSInteger nValue = [_table minIntValueOfColumn:@"age" where:@"age > :age" params:@{@"age":@(5)}];
    XCTAssert(nValue == 6);
}

- (void)testMinDoubleValue {
    double dValue  = [_table minDoubleValueOfColumn:@"progress"];
    
    XCTAssert(dValue == 0.0);
}

- (void)testMinDoubleValue_where {
    double dValue = [_table minDoubleValueOfColumn:@"progress" where:@""];
    
    XCTAssert(dValue == 0.0);
    
    dValue = [_table minDoubleValueOfColumn:@"progress" where:@"age > 7"];
    XCTAssert(dValue == 0.8);
}

- (void)testMinDoubleValue_where_params {
    double dValue = [_table minDoubleValueOfColumn:@"progress" where:@"age > :age" params:@{@"age":@(5)}];
    XCTAssert(dValue == 0.6);
}

- (void)testSumIntValue {
    UInt64 sum = [_table sumIntValueOfColumn:@"age"];
    XCTAssert(sum == 45);
}

- (void)testSumIntValue_where {
    UInt64 sum = [_table sumIntValueOfColumn:@"age" where:@"age > 7"];
    XCTAssert(sum == 17);
    
    sum = [_table sumIntValueOfColumn:@"age" where:@"age > 9"];
    XCTAssert(sum == 0);
}

- (void)testSumIntValue_where_params {
    UInt64 sum = [_table sumIntValueOfColumn:@"age" where:@"age > :age" params:@{@"age":@(7)}];
    XCTAssert(sum == 17);
    
    sum = [_table sumIntValueOfColumn:@"age" where:@"age > :age" params:@{@"age":@(9)}];
    XCTAssert(sum == 0);
}

- (void)testSumDoubleValue {
    double sum = [_table sumDoubleValueOfColumn:@"progress"];
    XCTAssert( (sum - 4.5 ) < 1e-8);
}

- (void)testSumDoubleValue_where {
    double sum = [_table sumDoubleValueOfColumn:@"progress" where:@"age < 3"];
    XCTAssert( (sum - 0.3) < 1e-8);
    
    sum = [_table sumDoubleValueOfColumn:@"age" where:@"age > 9"];
    XCTAssert( (sum - 0.0 ) < 1e-8);
}

- (void)testSumDoubleValue_where_params {
    double sum = [_table sumIntValueOfColumn:@"progress" where:@"age > :age" params:@{@"age":@(7)}];
    XCTAssert( (sum - 1.7 ) < 1e-8);
    
    sum = [_table sumIntValueOfColumn:@"progress" where:@"age > :age" params:@{@"age":@(9)}];
    XCTAssert((sum - 0.0 ) < 1e-8);
}

- (void)testAvgDoubleValue {
    double avg = [_table avgDoubleValueOfColumn:@"progress"];
    XCTAssert( (avg - 0.45 ) < 1e-8);
    
    avg = [_table avgDoubleValueOfColumn:@"age"];
    XCTAssert( (avg - 4.5 ) < 1e-8);
}

- (void)testAvgDoubleValue_where {
    double avg = [_table avgDoubleValueOfColumn:@"progress" where:@"age > 5"];
    XCTAssert( (avg - 0.75 ) < 1e-8);
    
    avg = [_table avgDoubleValueOfColumn:@"age" where:@"age < 5"];
    XCTAssert( (avg - 2 ) < 1e-8);
}

- (void)testAvgDoubleValue_where_params {
    double avg = [_table avgDoubleValueOfColumn:@"progress" where:@"age > :age" params:@{@"age":@(5)}];
    XCTAssert( (avg - 0.75 ) < 1e-8);
    
    avg = [_table avgDoubleValueOfColumn:@"age" where:@"age < :age" params:@{@"age":@(5)}];
    XCTAssert( (avg - 2 ) < 1e-8);
}

- (void)generateTestData {
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    
    for (NSInteger index = 0; index < 10; index++) {
        BNCSQLiteTestRecord *record = [[BNCSQLiteTestRecord alloc] init];
        record.name = [NSString stringWithFormat:@"testName_%ld",(long)index];
        record.age = index;
        record.progress = index / 10.0;
        record.timeStamp = 1000 + index;
        [arr addObject:record];
    }
    
    NSError *error = nil;
    
    BOOL isSuccess =  [_table insertRecordList:arr error:&error];
    
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
}

@end
