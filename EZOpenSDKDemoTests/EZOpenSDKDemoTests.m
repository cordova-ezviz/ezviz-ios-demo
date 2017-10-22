//
//  EZOpenSDKDemoTests.m
//  EZOpenSDKDemoTests
//
//  Created by DeJohn Dong on 15/10/27.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EZOpenSDK.h"
#import "EZPlayer.h"


static NSString *const unitTestKey = @"4bdf5701dfaa4e18bd2abe901274ae17";
static const NSTimeInterval timeOutInterval = 30.0f;

@interface EZOpenSDKDemoTests : XCTestCase

@end

@implementation EZOpenSDKDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [EZOpenSDK initLibWithAppKey:unitTestKey];
    
    EZPlayer *player = [EZPlayer createPlayerWithUrl:@""];
    player.delegate = self;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSquareColumn
{
    XCTestExpectation *expection = [self expectationWithDescription:NSLocalizedString(@"message_square_test", @"视频广场类别单元测试")];
//    NSOperation *op = [EZOpenSDK getSquareColumn:^(NSArray *squareColumns, NSError *error) {
//        if(error)
//        {
//            [expection fulfill];
//        }
//        else
//        {
//            [expection fulfill];
//        }
//    }];
//    
//    [self waitForExpectationsWithTimeout:timeOutInterval handler:^(NSError * _Nullable error) {
//        [op cancel];
//    }];
}

- (void)testExample {
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
