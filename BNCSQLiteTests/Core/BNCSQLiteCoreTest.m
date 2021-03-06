//
//  BNCSQLiteCoreTest.m
//  BNCSQLiteTests
//
//  Created by Jax Wu on 2018/7/2.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLite.h"
#import "BNCSQLiteDatabaseConfig.h"

@interface BNCSQLiteCoreTest : XCTestCase

@property(nonatomic,strong) NSString *filePath;
@property(nonatomic,strong) BNCSQLiteDatabase *db;

@end

@implementation BNCSQLiteCoreTest

- (void)setUp {
    [super setUp];
    
    self.filePath = @":memory:";
    
    BNCSQLiteDatabaseConfig *config = [[BNCSQLiteDatabaseConfig alloc] init];
    config.filePath = self.filePath;
    
    self.db = [[BNCSQLiteDatabase alloc] initWithConfig:config error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    [_db closeDatabase];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 删除文件
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
    
    isSuccess = [self.db executeSQL:sql bind:^(BNCSQLiteDatabaseStatement *statement) {
        [statement bindColumn:@":first_name" withTextValue:@"John2"];
    } rowHandle:nil error:nil];
    
    XCTAssertTrue(isSuccess);
}

- (void)testSelect {
    [self testInsertValue];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
    
    NSString *sql = @"SELECT * FROM contacts; ";
    
    [self.db currentVersion];
    
    BOOL isSuccess = [self.db executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowID) {
        NSDictionary *dic = [statement takeAllColumn];
        XCTAssert(dic.allKeys.count == 5);
        [arr addObject:dic];
    } error:nil];
    
    XCTAssertTrue(isSuccess);
    XCTAssert(arr.count == 2);
    
    [arr removeAllObjects];
    sql = @"SELECT first_name,last_name FROM contacts; ";
    
    isSuccess = [self.db executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowID) {
        NSDictionary *dic = [statement takeAllColumn];
        XCTAssert(dic.allKeys.count == 2);
        [arr addObject:dic];
    } error:nil];
    
    XCTAssertTrue(isSuccess);
    XCTAssert(arr.count == 2);
    
    [arr removeAllObjects];
    sql = @"SELECT first_name,last_name FROM contacts WHERE first_name = :first_name; ";
    
    isSuccess = [self.db executeSQL:sql bind:^(BNCSQLiteDatabaseStatement *statement) {
        [statement bindColumn:@":first_name" withTextValue:@"John"];
    } rowHandle:^(BNCSQLiteDatabaseStatement *statement, uint64_t rowID) {
        NSDictionary *dic = [statement takeAllColumn];
        XCTAssert(dic.allKeys.count == 2);
        [arr addObject:dic];
    } error:nil];
    
    XCTAssertTrue(isSuccess);
    XCTAssert(arr.count == 1);
    
    sql = @"SELECT COUNT(*) AS count FROM contacts ;";
    
    __block NSInteger nCount = 0;
    
    [self.db executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        nCount = [statement takeIntColumnAt:0];
    } error:nil];
    
    XCTAssert(2 == nCount);
}

@end
