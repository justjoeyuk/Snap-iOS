//
//  SnapUITests.m
//  SnapUITests
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <XCTest/XCTest.h>


@interface SnapUITests : XCTestCase

@end


@implementation SnapUITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    
}

@end
