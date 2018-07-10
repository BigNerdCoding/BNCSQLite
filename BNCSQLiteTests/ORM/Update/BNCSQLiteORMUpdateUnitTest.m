//
//  BNCSQLiteORMUpdateUnitTest.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/10.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLiteTestTable.h"
#import "BNCSQLiteTestRecord.h"
#import "BNCSQLiteTable+Insert.h"
#import "BNCSQLiteTable+Delete.h"
#import "BNCSQLiteTable+Find.h"
#import "BNCSQLiteTable+Update.h"

@interface BNCSQLiteORMUpdateUnitTest : XCTestCase

@property(nonatomic,strong) BNCSQLiteTestTable *table;

@end

@implementation BNCSQLiteORMUpdateUnitTest

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

- (void)testUpdateRecord {
    NSError *error = nil;
    
    BNCSQLiteTestRecord *record = [_table findWithPrimaryKey:@(1) error:&error];
    XCTAssertNotNil(record);
    XCTAssertNil(error);
    
    record.name = @"testNameUpdate";
    record.age = 20;
    record.progress = 0.1;
    record.timeStamp = 10000;
    
    BOOL isSuccess = [_table updateRecord:record error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    record = [_table findWithPrimaryKey:@(1) error:&error];
    XCTAssertNotNil(record);
    XCTAssertNil(error);
    
    XCTAssertEqual(20, record.age);
    XCTAssertEqual(0.1, record.progress);
    XCTAssertEqual(10000, record.timeStamp);
    XCTAssert([record.name isEqualToString:@"testNameUpdate"]);
}

- (void)testUpdateRecordList {
    NSError *error = nil;
    
    NSArray *allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(10, allRecord.count);
    
    for (BNCSQLiteTestRecord *record in allRecord) {
        record.name = @"testNameUpdate";
        record.age = 20;
        record.progress = 0.1;
    }
    
    BOOL isSuccess = [_table updateRecordList:allRecord error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(10, allRecord.count);
    
    for (BNCSQLiteTestRecord *record  in allRecord) {
        XCTAssertEqual(20, record.age);
        XCTAssertEqual(0.1, record.progress);
        XCTAssert([record.name isEqualToString:@"testNameUpdate"]);
    }
}

- (void)testUpdateValue_forColumn_condition_params {
    NSError *error = nil;
    
    BOOL isSuccess = [_table updateValue:@(0.1) forColumn:@"progress" condition:@"progress = :progressValue" params:@{@"progressValue":@(0.3)} error:&error];
    
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithColumn:@"progress" value:@(0.1) error:&error];
    XCTAssertEqual(5, allRecord.count);
    XCTAssertNil(error);
    
    allRecord = [_table findAllWithColumn:@"progress" value:@(0.3) error:&error];
    XCTAssertEqual(0, allRecord.count);
    XCTAssertNil(error);
}

- (void)testUpdateColumnValueList_condition_params {
    NSError *error = nil;
    
    BOOL isSuccess = [_table updateColumnValueList:@{@"progress":@(0.1),
                                                     @"name":@"testNameUpdate"
                                                     }
                                         condition:@"progress = :progressValue"
                                            params:@{@"progressValue":@(0.3)}
                                             error:&error];
    
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithColumn:@"progress" value:@(0.1) error:&error];
    XCTAssertEqual(5, allRecord.count);
    XCTAssertNil(error);
    
    for (BNCSQLiteTestRecord *record  in allRecord) {
        XCTAssertEqual(0.1, record.progress);
        XCTAssert([record.name isEqualToString:@"testNameUpdate"]);
    }
    
    allRecord = [_table findAllWithColumn:@"progress" value:@(0.3) error:&error];
    XCTAssertEqual(0, allRecord.count);
    XCTAssertNil(error);
}

- (void)testUpdateValue_forColumn_whereKey_inValueList {
    NSError *error = nil;
    
    BOOL isSuccess = [_table updateValue:@(0.1) forColumn:@"progress" whereKey:@"timeStamp" inList:@[@(1000),@(1001),@(1002)] error:&error];
    
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithColumn:@"timeStamp" inValueList:@[@(1000),@(1001),@(1002)] error:&error];
    XCTAssertEqual(3, allRecord.count);
    XCTAssertNil(error);
    
    for (BNCSQLiteTestRecord *record  in allRecord) {
        XCTAssertEqual(0.1, record.progress);
    }
}

- (void)testUpdateValueList_forColumn_whereKey_inValueList {
    NSError *error = nil;
    
    BOOL isSuccess = [_table updateColumnValueList:@{@"progress":@(0.1),
                                                     @"name":@"testNameUpdate"}
                                          whereKey:@"timeStamp" inList:@[@(1000),@(1001),@(1002)] error:&error];
    
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithColumn:@"timeStamp" inValueList:@[@(1000),@(1001),@(1002)] error:&error];
    XCTAssertEqual(3, allRecord.count);
    XCTAssertNil(error);
    
    for (BNCSQLiteTestRecord *record  in allRecord) {
        XCTAssertEqual(0.1, record.progress);
        XCTAssert([record.name isEqualToString:@"testNameUpdate"]);
    }
}

- (void)testUpdateValue_forColumn_primaryKey {
    NSError *error = nil;
    
    BOOL isSuccess = [_table updateValue:@(0.1) forColumn:@"progress" primaryKey:@(2) error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    BNCSQLiteTestRecord *record  = [_table findWithPrimaryKey:@(2) error:&error];
    XCTAssertNotNil(record);
    XCTAssertEqual(0.1, record.progress);
}

- (void)testUpdateColumnValueList_primaryKey {
    NSError *error = nil;
    
    BOOL isSuccess = [_table updateColumnValueList:@{@"progress":@(0.1),
                                                     @"name":@"testNameUpdate"} primaryKey:@(2) error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    BNCSQLiteTestRecord *record  = [_table findWithPrimaryKey:@(2) error:&error];
    XCTAssertNotNil(record);
    XCTAssertEqual(0.1, record.progress);
    XCTAssert([record.name isEqualToString:@"testNameUpdate"]);
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
