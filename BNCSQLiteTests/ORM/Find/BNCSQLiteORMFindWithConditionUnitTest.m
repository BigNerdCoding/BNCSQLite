//
//  BNCSQLiteORMSelectUnitTest.m
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

@interface BNCSQLiteORMFindWithConditionUnitTest : XCTestCase

@property(nonatomic,strong) BNCSQLiteTestTable *table;

@end

@implementation BNCSQLiteORMFindWithConditionUnitTest

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

- (void)testFindAllWithError {
    NSError *error = nil;
    
    NSArray *results = [_table findAllWithError:&error];
    
    XCTAssert(results.count == 10);
    XCTAssertNil(error);
}

- (void)testFindAllWithOrder {
    NSError *error = nil;
    
    NSArray *results = [_table findAllWithOrder:@"timeStamp desc" error:&error];
    
    XCTAssert(results.count == 10);
    XCTAssertNil(error);
    
    BNCSQLiteTestRecord *record = [results firstObject];
    long long timeStamp = record.timeStamp;
    
    for (NSInteger index = 1; index < results.count; index++) {
        record = [results objectAtIndex:index];
        
        XCTAssert(timeStamp >= record.timeStamp);
        
        timeStamp = record.timeStamp;
    }
}

- (void)testFindLatestRecordWithError {
    NSError *error = nil;
    
    BNCSQLiteTestRecord *record = [_table findLatestRecordWithError:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(record);
    XCTAssertEqual(record.age, 9);
}

- (void)testFindLatestRecordWithOrder {
    NSError *error = nil;
    
    BNCSQLiteTestRecord *record = [_table findLatestRecordWithOrder:@"age desc" error:&error];
    
    XCTAssertNil(error);
    XCTAssertNotNil(record);
    XCTAssertEqual(record.timeStamp, 1000);
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
