//
//  BNCSQLiteORMFindWithReadyConditionUnitTest.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/9/18.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLiteTestTable.h"
#import "BNCSQLiteTestRecord.h"
#import "BNCSQLiteTable+Insert.h"
#import "BNCSQLiteTable+Find.h"
#import "BNCSQLiteTable+Delete.h"

@interface BNCSQLiteORMFindWithReadyConditionUnitTest : XCTestCase

@property(nonatomic,strong) BNCSQLiteTestTable *table;

@end

@implementation BNCSQLiteORMFindWithReadyConditionUnitTest

- (void)setUp {
    [super setUp];
    
    _table = [[BNCSQLiteTestTable alloc] init];
    [self generateTestData];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    [super tearDown];
    
    BOOL isSuccess = [_table truncate];
    XCTAssertTrue(isSuccess);
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testFindAllWithWhere {
    NSError *error = nil;
    
    NSArray *result = [_table findAllWithWhere:@"age = 20" error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 0);
    
    result = [_table findAllWithWhere:@"age > 4" error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 5);
}

- (void)testFindAllWithWhere_orderBy {
    NSError *error = nil;
    
    NSArray *result  = [_table findAllWithWhere:@"age > 4"  orderBy:@"age DESC" error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 5);
    
    BNCSQLiteTestRecord *record = [result firstObject];
    NSInteger age = record.age;
    for (NSInteger index = 1; index < result.count; index++) {
        record = [result objectAtIndex:index];
        XCTAssert(age >= record.age);
        age = record.age;
    }
}

- (void)testFindAllWithWhere_limit {
    NSError *error = nil;
    
    NSArray *result  = [_table findRecordWithWhere:@"age > 4"  limit:0 error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 5);
    
    result  = [_table findRecordWithWhere:@"age > 4" limit:1 error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 1);
}

- (void)testFindAllWithWhere_orderBy_limit {
    NSError *error = nil;
    
    NSArray *result  = [_table findRecordWithWhere:@"age > 4"  orderBy:@"age DESC" limit:0 error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 5);
    
    BNCSQLiteTestRecord *record = [result firstObject];
    NSInteger age = record.age;
    for (NSInteger index = 1; index < result.count; index++) {
        record = [result objectAtIndex:index];
        XCTAssert(age >= record.age);
        age = record.age;
    }
    
    result  = [_table findRecordWithWhere:@"age > 4"  orderBy:@"age DESC" limit:1 error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(result.count, 1);
    
    record = [result firstObject];
    XCTAssert(record.age == 9);
}

- (void)generateTestData {
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    
    for (NSInteger index = 0; index < 10; index++) {
        BNCSQLiteTestRecord *record = [[BNCSQLiteTestRecord alloc] init];
        record.name = [NSString stringWithFormat:@"testName_%ld",(long)index];
        record.age = index;
        
        record.timeStamp = 1000 + index;
        [arr addObject:record];
    }
    
    NSError *error = nil;
    
    BOOL isSuccess =  [_table insertRecordList:arr error:&error];
    
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
}

@end
