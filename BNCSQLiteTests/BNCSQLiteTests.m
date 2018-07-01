//
//  BNCSQLiteTests.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/6/29.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLite.h"

@interface BNCSQLiteTests : XCTestCase

@end

@implementation BNCSQLiteTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSString *databaseFilePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"BNCSQLite.sqlite"];
    
    BNCDataBase *db = [[BNCDataBase alloc] initWithPath:databaseFilePath error:nil];
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS contacts ( contact_id integer PRIMARY KEY,first_name text NOT NULL,last_name text NOT NULL,email text NOT NULL UNIQUE,phone text NOT NULL UNIQUE);";
    
    [db executeSQL:sql bind:nil rowHandle:nil error:nil];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
