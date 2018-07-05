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
#import "BNCSQLiteTable+Find.h"
#import "BNCSQLiteTable+Delete.h"

@interface BNCSQLiteORMFindGeneralUnitTest : XCTestCase

@property(nonatomic,strong) BNCSQLiteTestTable *table;

@end

@implementation BNCSQLiteORMFindGeneralUnitTest

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
    NSInteger count = [_table countWithCondition:@"age > :age" params:@{@"age":@(5)}];
    XCTAssert(count == 4);
    
    
    count = [_table countWithCondition:@"age > :age AND timeStamp < :timeStamp" params:@{@"age":@(5),
                                                                                         @"timeStamp":@(1007)
                                                                                         }];
    XCTAssert(count == 1);
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
