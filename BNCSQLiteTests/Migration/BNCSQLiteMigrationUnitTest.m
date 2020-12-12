//
//  BNCSQLiteMigrationUnitTest.m
//  BNCSQLiteTests
//
//  Created by Jax Wu on 2018/7/10.
//  Copyright © 2018年 Jax Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BNCSQLiteMigrationTestTableV1.h"
#import "BNCSQLiteMigrationTestTableV2.h"
#import "BNCSQLiteMigrationTestTableV3.h"
#import "BNCSQLiteMigrationTestTableV4.h"
#import "NSString+BNCSQLiteSchema.h"
#import "BNCSQLiteDatabaseStatement+Take.h"
#import "BNCSQLiteDatabasePool.h"

@interface BNCSQLiteMigrationUnitTest : XCTestCase

@end

@implementation BNCSQLiteMigrationUnitTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"BNCSQLiteMigrationTest.sqlite"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 删除文件
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

- (void)testVersion1_to_Version2 {
    NSError *error = nil;
    
    BNCSQLiteMigrationTestTableV1 *v1Table = [[BNCSQLiteMigrationTestTableV1 alloc] init];
    
    NSString *sql = [NSString columnInfoWithTableName:[v1Table tableName]];
    
    __block NSMutableArray *allColumn = [NSMutableArray array];
    [[v1Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 2);
    
    // Close DB Connect
    [[BNCSQLiteDatabasePool sharedInstance] closeAllDatabaseInCurrentThread];
    
    // V2 Table
    BNCSQLiteMigrationTestTableV2 *v2Table = [[BNCSQLiteMigrationTestTableV2 alloc] init];
    
    sql = [NSString columnInfoWithTableName:[v2Table tableName]];
    
    allColumn = [NSMutableArray array];
    [[v2Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 3);
    
}

- (void)testVersion1_to_Version3 {
    NSError *error = nil;
    
    BNCSQLiteMigrationTestTableV1 *v1Table = [[BNCSQLiteMigrationTestTableV1 alloc] init];
    
    NSString *sql = [NSString columnInfoWithTableName:[v1Table tableName]];
    
    __block NSMutableArray *allColumn = [NSMutableArray array];
    [[v1Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 2);
    
    // Close DB Connect
    [[BNCSQLiteDatabasePool sharedInstance] closeAllDatabaseInCurrentThread];
    
    // V2 Table
    BNCSQLiteMigrationTestTableV3 *v3Table = [[BNCSQLiteMigrationTestTableV3 alloc] init];
    
    sql = [NSString columnInfoWithTableName:[v3Table tableName]];
    
    allColumn = [NSMutableArray array];
    [[v3Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 4);
}

- (void)testVersion1_to_Version4 {
    NSError *error = nil;
    
    BNCSQLiteMigrationTestTableV1 *v1Table = [[BNCSQLiteMigrationTestTableV1 alloc] init];
    
    NSString *sql = [NSString columnInfoWithTableName:[v1Table tableName]];
    
    __block NSMutableArray *allColumn = [NSMutableArray array];
    [[v1Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 2);
    
    // Close DB Connect
    [[BNCSQLiteDatabasePool sharedInstance] closeAllDatabaseInCurrentThread];
    
    // V2 Table
    BNCSQLiteMigrationTestTableV4 *v4Table = [[BNCSQLiteMigrationTestTableV4 alloc] init];
    
    sql = [NSString columnInfoWithTableName:[v4Table tableName]];
    
    allColumn = [NSMutableArray array];
    [[v4Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 5);
}

- (void)testVersion2_to_Version3 {
    NSError *error = nil;
    
    BNCSQLiteMigrationTestTableV2 *v2Table = [[BNCSQLiteMigrationTestTableV2 alloc] init];
    
    NSString *sql = [NSString columnInfoWithTableName:[v2Table tableName]];
    
    __block NSMutableArray *allColumn = [NSMutableArray array];
    [[v2Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 3);
    
    // Close DB Connect
    [[BNCSQLiteDatabasePool sharedInstance] closeAllDatabaseInCurrentThread];
    
    // V2 Table
    BNCSQLiteMigrationTestTableV3 *v3Table = [[BNCSQLiteMigrationTestTableV3 alloc] init];
    
    sql = [NSString columnInfoWithTableName:[v3Table tableName]];
    
    allColumn = [NSMutableArray array];
    [[v3Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 4);
}

- (void)testVersion2_to_Version4 {
    NSError *error = nil;
    
    BNCSQLiteMigrationTestTableV2 *v2Table = [[BNCSQLiteMigrationTestTableV2 alloc] init];
    
    NSString *sql = [NSString columnInfoWithTableName:[v2Table tableName]];
    
    __block NSMutableArray *allColumn = [NSMutableArray array];
    [[v2Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 3);
    
    // Close DB Connect
    [[BNCSQLiteDatabasePool sharedInstance] closeAllDatabaseInCurrentThread];
    
    // V2 Table
    BNCSQLiteMigrationTestTableV4 *v4Table = [[BNCSQLiteMigrationTestTableV4 alloc] init];
    
    sql = [NSString columnInfoWithTableName:[v4Table tableName]];
    
    allColumn = [NSMutableArray array];
    [[v4Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 5);
}

- (void)testVersion3_to_Version4 {
    NSError *error = nil;
    
    BNCSQLiteMigrationTestTableV3 *v3Table = [[BNCSQLiteMigrationTestTableV3 alloc] init];
    
    NSString *sql = [NSString columnInfoWithTableName:[v3Table tableName]];
    
    __block NSMutableArray *allColumn = [NSMutableArray array];
    [[v3Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 4);
    
    // Close DB Connect
    [[BNCSQLiteDatabasePool sharedInstance] closeAllDatabaseInCurrentThread];
    
    // V2 Table
    BNCSQLiteMigrationTestTableV4 *v4Table = [[BNCSQLiteMigrationTestTableV4 alloc] init];
    
    sql = [NSString columnInfoWithTableName:[v4Table tableName]];
    
    allColumn = [NSMutableArray array];
    [[v4Table dbConnect] executeSQL:sql bind:nil rowHandle:^(BNCSQLiteDatabaseStatement *statement, UInt64 rowNum) {
        NSDictionary *dic = [statement takeAllColumn];
        [allColumn addObject:dic];
    } error:&error];
    
    XCTAssert(allColumn.count == 5);
}

@end
