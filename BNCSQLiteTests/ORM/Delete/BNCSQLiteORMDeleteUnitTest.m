//
//  BNCSQLiteORMDeleteUnitTest.m
//  BNCSQLiteTests
//
//  Created by Jax Wu on 2018/7/10.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLiteTestTable.h"
#import "BNCSQLiteTestRecord.h"
#import "BNCSQLiteTable+Insert.h"
#import "BNCSQLiteTable+Delete.h"
#import "BNCSQLiteTable+Find.h"

@interface BNCSQLiteORMDeleteUnitTest : XCTestCase

@property(nonatomic,strong) BNCSQLiteTestTable *table;

@end

@implementation BNCSQLiteORMDeleteUnitTest

- (void)setUp {
    [super setUp];
    
    _table = [[BNCSQLiteTestTable alloc] init];
    [self generateTestData];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    [self testTruncate];
}

- (void)testDeleteRecord {
    NSError *error = nil;
    
    NSArray *allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 10);
    XCTAssertNil(error);
    
    BNCSQLiteTestRecord *record = [[BNCSQLiteTestRecord alloc] init];
    record.rowID = @(1);
    
    BOOL isSuccess = [_table deleteRecord:record error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 9);
    
    record.rowID = @(0);
    isSuccess = [_table deleteRecord:record error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 9);
}

- (void)testDeleteRecordList {
    NSError *error = nil;
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger index = 0; index < 5; index++) {
        BNCSQLiteTestRecord *record = [[BNCSQLiteTestRecord alloc] init];
        record.rowID = @(index);
        [arr addObject:record];
    }
    
    BOOL isSuccess = [_table deleteRecordList:arr error:&error];
    
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 6);
}

- (void)testDeleteWithCondition_params {
    NSError *error = nil;
    
    BOOL isSuccess = [_table deleteWithCondition:@"progress = :progressValue AND age < :ageValue"
                                          params:@{@"progressValue":@(0.3),@"ageValue":@(4)}
                                           error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 8);
    
    isSuccess = [_table deleteWithCondition:@"name = :nameValue"
                                     params:@{@"nameValue":@"testName_2"}
                                      error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 7);
}

- (void)testDeleteWithPrimaryKey {
    NSError *error = nil;
    BOOL isSuccess = [_table deleteWithPrimaryKey:@(2) error:&error];
    
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 9);
}

- (void)testDeleteWithPrimaryKeyList {
    NSError *error = nil;
    BOOL isSuccess = [_table deleteWithPrimaryKeyList:@[@(9),@(8),@(7),@(0)] error:&error];
    
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 7);
}

- (void)testDeleteRecordWhereColumn {
    NSError *error = nil;
    
    BOOL isSuccess = [_table deleteRecordWhereColumn:@"name" value:@"testName_2" error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    isSuccess = [_table deleteRecordWhereColumn:@"progress" value:@"0.3" error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 4);
}

- (void)testDeleteRecordWhereColumn_inValueList {
    NSError *error = nil;
    
    BOOL isSuccess = [_table deleteRecordWhereColumn:@"name" inValueList:@[@"testName_2",@"testName_3",@"testName_4",@"testName_5"] error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 6);
}

- (void)testDeleteRecordWhere {
    NSError *error = nil;
    
    BOOL isSuccess = [_table deleteRecordWhere:@"progress = 0.3 AND age < 4" error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    NSArray *allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 8);
    
    isSuccess = [_table deleteRecordWhere:@"name = 'testName_2'" error:&error];
    XCTAssertTrue(isSuccess);
    XCTAssertNil(error);
    
    allRecord = [_table findAllWithError:&error];
    XCTAssertEqual(allRecord.count, 7);
}

- (void)testTruncate {
    BOOL isSuccess = [_table truncate];
    XCTAssertTrue(isSuccess);
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
