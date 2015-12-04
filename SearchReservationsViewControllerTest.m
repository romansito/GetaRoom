//
//  SearchReservationsViewControllerTest.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/3/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchReservationsViewController.h"
@interface SearchReservationsViewControllerTest : XCTestCase

@property (strong, nonatomic)SearchReservationsViewController *testVC;

@end

@implementation SearchReservationsViewControllerTest

- (void)setUp {
    [super setUp];
	
	self.testVC = [[SearchReservationsViewController alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitializer {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
	
	XCTAssertNotNil(self.testVC);
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
