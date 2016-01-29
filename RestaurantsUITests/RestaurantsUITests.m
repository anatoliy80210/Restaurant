//
//  RestaurantsUITests.m
//  RestaurantsUITests
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RestaurantsUITests : XCTestCase

@end

@implementation RestaurantsUITests

- (void)setUp
{
    [super setUp];

    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTabbarUI
{
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCUIElement *lunchButton = tabBarsQuery.buttons[@"lunch"];

    XCTAssert(lunchButton.exists);

    XCUIElement *internetsButton = tabBarsQuery.buttons[@"internets"];
    XCTAssert(internetsButton.exists);

    [internetsButton tap];

    XCTAssert([app.webViews.element exists]);

    [lunchButton tap];
    XCTAssert([app.navigationBars[@"Lunch Time"].staticTexts[@"Lunch Time"] exists]);
}

- (void)testLunchTab
{
    // TODO: Add tests for lunch tab
}

- (void)testWebTab
{
    // TODO: Add tests for Web
}

@end