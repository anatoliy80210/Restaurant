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

    NSDictionary *contactDictionary = @{ @"phone": @"1234567",
                                         @"formattedPhone": @"1-123-4567",
                                         @"twitter": @"BottleRocket" };

    self.contact = [[Contact alloc] initWithDictionary:contactDictionary];
    
    NSDictionary *locationDictionary = @{ @"address": @"some address",
                                          @"crossStreet": @"some crossStreet",
                                          @"lat": @113.311,
                                          @"lng": @ - 1543.3333,
                                          @"postalCode": @"76210",
                                          @"cc": @"US",
                                          @"country": @"United States",
                                          @"city": @"Plano",
                                          @"state": @"TX",
                                          @"formattedAddress": @[@"Number", @"Street", @"Plano", @"TX", @"United States"] };
    
    self.location = [[Location alloc] initWithDictionary:locationDictionary];
    

    NSDictionary *dictionary = @{ @"name": @"BottleRocket",
                                  @"backgroundImageURL": @"http://bottlerocketstudios.com/someImage.jpg",
                                  @"category": @"iOS",
                                  @"contact": contactDictionary };

    self.restaurant = [[Restaurant alloc] initWithDictionary:dictionary];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testName
{
    XCTAssertEqual(self.restaurant.name, @"BottleRocket");
}

- (void)testCategory
{
    XCTAssertEqual(self.restaurant.category, @"iOS");
}

- (void)testBackgrounImage
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://bottlerocketstudios.com/someImage.jpg"];

    XCTAssertEqual(self.restaurant.backgroundImageURL, url);
}

- (void)testContact
{
    XCTAssertEqual(self.restaurant.contact.phone, self.contact.phone);
    XCTAssertEqual(self.restaurant.contact.formattedPhone, self.contact.formattedPhone);
    XCTAssertEqual(self.restaurant.contact.twitter, self.contact.twitter);
}

- (void)testLocation
{
    XCTAssertEqual(self.restaurant.location.address, self.location.address);
    XCTAssertEqual(self.restaurant.location.crossStreet, self.location.crossStreet);
    XCTAssertEqual(self.restaurant.location.postalCode, self.location.postalCode);
    XCTAssertEqual(self.restaurant.location.country, self.location.country);
    XCTAssertEqual(self.restaurant.location.countryCode, self.location.countryCode);
    XCTAssertEqual(self.restaurant.location.state, self.location.state);
    XCTAssertEqual(self.restaurant.location.city, self.location.city);
    XCTAssertEqual(self.restaurant.location.formattedAddress, self.location.formattedAddress);
    XCTAssertEqual(self.restaurant.location.longitude, self.location.longitude);
    XCTAssertEqual(self.restaurant.location.latitude, self.location.latitude);
}

@end