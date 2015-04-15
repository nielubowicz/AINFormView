//
//  AINFormViewTests.m
//  AINFormViewTests
//
//  Created by chris nielubowicz on 1/23/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AINFormView.h"

@interface AINFormViewTests : XCTestCase <AINFormViewDataSouce,AINFormViewDelegate>

@end

@implementation AINFormViewTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFormViewCreation
{
    AINFormView *formView = [[AINFormView alloc] init];
    XCTAssertNotNil(formView, @"FormView object should not be nil");
 
    
}


@end
