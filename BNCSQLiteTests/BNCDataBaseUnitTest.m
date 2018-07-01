//
//  BNCDataBaseUnitTest.m
//  BNCSQLiteTests
//
//  Created by Karsa Wu on 2018/7/1.
//  Copyright © 2018年 Karsa Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLite.h"
#import "BNCDataBaseStatement+Bind.h"

@interface BNCDataBaseUnitTest : XCTestCase

@property(nonatomic,strong) NSString *filePath;
@property(nonatomic,strong) BNCDataBase *db;

@end

@implementation BNCDataBaseUnitTest

- (void)setUp {
    [super setUp];
    
    self.filePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"BNCSQLite.sqlite"];
    
    self.db = [[BNCDataBase alloc] initWithPath:_filePath error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 关闭数据库连接
    if ([fileManager fileExistsAtPath:_filePath]) {
        [fileManager removeItemAtPath:_filePath error:nil];
    }
}

- (void)testCreateTable {
    NSString *sql = @"CREATE TABLE IF NOT EXISTS contacts ( contact_id integer PRIMARY KEY,first_name text NOT NULL,last_name text NOT NULL,email text NOT NULL UNIQUE,phone text NOT NULL UNIQUE);";
    
    BOOL isSuccess = [self.db executeSQL:sql bind:nil rowHandle:nil error:nil];
    XCTAssertTrue(isSuccess);
}

- (void)testInsertValue {
    [self testCreateTable];
    
    NSString *sql = @"INSERT INTO contacts (first_name, last_name, email, phone) VALUES ('John','Doe','john.doe@sqlitetutorial.net','xxxxxxx'); ";
    
    BOOL isSuccess = [self.db executeSQL:sql bind:nil rowHandle:nil error:nil];
    XCTAssertTrue(isSuccess);
    
    // Abort due to constraint violation
    sql = @"INSERT INTO contacts (first_name, last_name, email) VALUES ('John2','Doe2','john2.doe@sqlitetutorial.net'); ";
    
    isSuccess = [self.db executeSQL:sql bind:nil rowHandle:nil error:nil];
    XCTAssertFalse(isSuccess);
    
    // Insert with bind
    sql = @"INSERT INTO contacts (first_name, last_name, email, phone) VALUES (:first_name,'Doe','john.doe2@sqlitetutorial.net','xxxxxxx2'); ";
    
    isSuccess = [self.db executeSQL:sql bind:^(BNCDataBaseStatement *statement) {
        [statement bindColumn:@":first_name" withTextValue:@"John2"];
    } rowHandle:nil error:nil];
    
    XCTAssertTrue(isSuccess);
}

- (void)testSelect {
    [self testInsertValue];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
    
    NSString *sql = @"SELECT * FROM contacts; ";
    
    BOOL isSuccess = [self.db executeSQL:sql bind:nil rowHandle:^(BNCDataBaseStatement *statement, uint64_t rowID) {
        NSDictionary *dic = [statement takeAllColumn];
        XCTAssert(dic.allKeys.count == 5);
        [arr addObject:dic];
    } error:nil];
    
    XCTAssertTrue(isSuccess);
    XCTAssert(arr.count == 2);
    
    [arr removeAllObjects];
    sql = @"SELECT first_name,last_name FROM contacts; ";
    
    isSuccess = [self.db executeSQL:sql bind:nil rowHandle:^(BNCDataBaseStatement *statement, uint64_t rowID) {
        NSDictionary *dic = [statement takeAllColumn];
        XCTAssert(dic.allKeys.count == 2);
        [arr addObject:dic];
    } error:nil];
    
    XCTAssertTrue(isSuccess);
    XCTAssert(arr.count == 2);
    
    [arr removeAllObjects];
    sql = @"SELECT first_name,last_name FROM contacts WHERE first_name = :first_name; ";
    
    isSuccess = [self.db executeSQL:sql bind:^(BNCDataBaseStatement *statement) {
        [statement bindColumn:@":first_name" withTextValue:@"John"];
    } rowHandle:^(BNCDataBaseStatement *statement, uint64_t rowID) {
        NSDictionary *dic = [statement takeAllColumn];
        XCTAssert(dic.allKeys.count == 2);
        [arr addObject:dic];
    } error:nil];
    
    XCTAssertTrue(isSuccess);
    XCTAssert(arr.count == 1);
}



@end
