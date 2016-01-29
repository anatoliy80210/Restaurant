//
//  RestaurantTest.m
//  RestaurantsTests
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Contact.h"
#import "Location.h"
#import "Restaurant.h"
#import <XCTest/XCTest.h>

@interface RestaurantTest : XCTestCase
@property (nonatomic, strong, nonnull) Restaurant *restaurant;
@property (nonatomic, strong, nonnull) Contact *contact;
@property (nonatomic, strong, nonnull) Location *location;
@end

@implementation RestaurantTest

- (void)setUp
{
    [super setUp];

    NSURL *localJsonURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"RestaurantsMock" withExtension:@".json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:localJsonURL];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSDictionary *restaurantDictionary = jsonDictionary[@"restaurants"][0];
    NSDictionary *contactDictionary = restaurantDictionary[@"contact"];
    NSDictionary *locationDictionary = restaurantDictionary[@"location"];

    self.contact = [[Contact alloc] initWithDictionary:contactDictionary];
    self.location = [[Location alloc] initWithDictionary:locationDictionary];

    self.restaurant = [[Restaurant alloc] initWithDictionary:restaurantDictionary];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testName
{
    XCTAssert([self.restaurant.name isEqualToString:@"Hopdoddy Burger Bar"]);
}

- (void)testCategory
{
    XCTAssert([self.restaurant.category isEqualToString:@"Burgers"]);
}

- (void)testBackgroundImage
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/Images/hopdoddy.png"];

    XCTAssert([self.restaurant.backgroundImageURL.absoluteString isEqualToString:url.absoluteString]);
}

- (void)testContact
{
    XCTAssert([self.restaurant.contact.phone isEqualToString:self.contact.phone]);
    XCTAssert([self.restaurant.contact.formattedPhone isEqualToString:self.contact.formattedPhone]);
    XCTAssert([self.restaurant.contact.twitter isEqualToString:self.contact.twitter]);
}

- (void)testLocation
{
    XCTAssert([self.restaurant.location.address isEqualToString:self.location.address]);
    XCTAssert([self.restaurant.location.crossStreet isEqualToString:self.location.crossStreet]);
    XCTAssert([self.restaurant.location.postalCode isEqualToString:self.location.postalCode]);
    XCTAssert([self.restaurant.location.country isEqualToString:self.location.country]);
    XCTAssert([self.restaurant.location.countryCode isEqualToString:self.location.countryCode]);
    XCTAssert([self.restaurant.location.state isEqualToString:self.location.state]);
    XCTAssert([self.restaurant.location.city isEqualToString:self.location.city]);
    XCTAssert([self.restaurant.location.formattedAddress isEqualToString:self.location.formattedAddress]);

    XCTAssertEqual(self.restaurant.location.longitude, self.location.longitude);
    XCTAssertEqual(self.restaurant.location.latitude, self.location.latitude);
}

@end