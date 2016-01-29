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

    NSURL *localJsonURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"RestaurantsMock" withExtension:@".json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:localJsonURL];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSDictionary *restaurantDictionary = jsonDictionary[@"restaurants"][0];
    NSDictionary *contactDictionary = restaurantDictionary[@"contact"];

    self.contact = [[Contact alloc] initWithDictionary:contactDictionary];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPhone
{
    XCTAssert([self.contact.phone isEqualToString:@"9723872337"]);
}

- (void)testFormattedPhone
{
    XCTAssert([self.contact.formattedPhone isEqualToString:@"(972) 387-2337"]);
}

- (void)testTwitter
{
    XCTAssert([self.contact.twitter isEqualToString:@"hopdoddy"]);
}

@end