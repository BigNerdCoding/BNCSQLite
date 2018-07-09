//
//  BNCSQLiteORMInsertUnitTest.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/9.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLiteTestTable.h"
#import "BNCSQLiteTestRecord.h"
#import "BNCSQLiteTable+Insert.h"
#import "BNCSQLiteTable+Delete.h"
#import "BNCSQLiteTable+Find.h"

@interface BNCSQLiteORMInsertUnitTest : XCTestCase

@property(nonatomic,strong) BNCSQLiteTestTable *table;

@end

@implementation BNCSQLiteORMInsertUnitTest

- (void)setUp {
    [super setUp];
    
    _table = [[BNCSQLiteTestTable alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    BOOL isSuccess = [_table truncate];
    XCTAssertTrue(isSuccess);
}

- (void)testInsertValidRecord {
    NSError *error = nil;
    
    BNCSQLiteTestRecord *record = [[BNCSQLiteTestRecord alloc] init];
    record.name = @"";
    record.age = 1;
    
    record.timeStamp = 1000;
    BOOL isSuccess = [_table insertRecord:record error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *results = [_table findAllWithError:&error];
    
    XCTAssert(results.count == 1);
    XCTAssertNil(error);
}


- (void)testInsertInalidRecord {
    NSError *error = nil;
    
    BNCSQLiteTestRecord *record = [[BNCSQLiteTestRecord alloc] init];
    record.age = 1;
    record.timeStamp = 1000;
    BOOL isSuccess = [_table insertRecord:record error:&error];
    XCTAssertFalse(isSuccess);
    XCTAssertNotNil(error);
    
    error = nil;
    
    NSArray *results = [_table findAllWithError:&error];
    
    XCTAssert(results.count == 0);
    XCTAssertNil(error);
}

- (void)testInsertValidRecordList {
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
    
    NSArray *results = [_table findAllWithError:&error];
    
    XCTAssert(results.count == 10);
    XCTAssertNil(error);
}

- (void)testInsertInvalidRecordList {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    
    for (NSInteger index = 0; index < 10; index++) {
        BNCSQLiteTestRecord *record = [[BNCSQLiteTestRecord alloc] init];
        record.name = [NSString stringWithFormat:@"testName_%ld",(long)index];
        record.age = index;
        
        record.timeStamp = 1000;
        [arr addObject:record];
    }
    
    NSError *error = nil;
    
    BOOL isSuccess =  [_table insertRecordList:arr error:&error];
    
    XCTAssertFalse(isSuccess);
    XCTAssertNotNil(error);
    
    error = nil;
    NSArray *results = [_table findAllWithError:&error];
    
    XCTAssert(results.count == 0);
    XCTAssertNil(error);
}

@end
