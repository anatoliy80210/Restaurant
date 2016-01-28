//
//  ContactTest.m
//  Restaurants
//
//  Created by Landron, Emil on 1/28/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Contact.h"
#import <XCTest/XCTest.h>

@interface ContactTest : XCTestCase
@property (nonatomic, strong, nonnull) Contact *contact;
@end

@implementation ContactTest

- (void)setUp
{
    [super setUp];

    NSDictionary *contactDictionary = @{ @"phone": @"1234567", @"formattedPhone": @"1-123-4567", @"twitter": @"BottleRocket" };
    self.contact = [[Contact alloc] initWithDictionary:contactDictionary];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPhone
{
    XCTAssertEqual(self.contact.phone, @"1234567");
}

- (void)testFormattedPhone
{
    XCTAssertEqual(self.contact.formattedPhone, @"1-123-4567");
}

- (void)testTwitter
{
    XCTAssertEqual(self.contact.twitter, @"BottleRocket");
}

@end