//
//  LocationTest.m
//  Restaurants
//
//  Created by Landron, Emil on 1/28/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Location.h"
#import <XCTest/XCTest.h>

static NSString *const kLocationAddressKey = @"address";
static NSString *const kLocationCrossStreetKey = @"crossStreet";
static NSString *const kLocationLatitudeKey = @"lat";
static NSString *const kLocationLongitudeKey = @"lng";
static NSString *const kLocationPostalCodeKey = @"postalCode";
static NSString *const kLocationCountryCodeKey = @"cc";
static NSString *const kLocationCityKey = @"city";
static NSString *const kLocationStateKey = @"state";
static NSString *const kLocationCountryKey = @"country";
static NSString *const kLocationFormattedAddressKey = @"formattedAddress";

@interface LocationTest : XCTestCase
@property (nonatomic, strong, nonnull) Location *location;
@end

@implementation LocationTest

- (void)setUp
{
    [super setUp];

    NSURL *localJsonURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"RestaurantsMock" withExtension:@".json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:localJsonURL];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSDictionary *restaurantDictionary = jsonDictionary[@"restaurants"][0];
    NSDictionary *locationDictionary = restaurantDictionary[@"location"];
    self.location = [[Location alloc] initWithDictionary:locationDictionary];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAddress
{
    XCTAssert([self.location.address isEqualToString:@"5100 Belt Line Road, STE 502"]);
}

- (void)testCrossStreet
{
    XCTAssert([self.location.crossStreet isEqualToString:@"Dallas North Tollway"]);
}

- (void)testLatitude
{
    XCTAssertEqual(self.location.latitude, 32.950787);
}

- (void)testLongitude
{
    XCTAssertEqual(self.location.longitude, -96.821118);
}

- (void)testPostalCode
{
    XCTAssert([self.location.postalCode isEqualToString:@"75254"]);
}

- (void)testCountryCode
{
    XCTAssert([self.location.countryCode isEqualToString:@"US"]);
}

- (void)testCountry
{
    XCTAssert([self.location.country isEqualToString:@"United States"]);
}

- (void)testCity
{
    XCTAssert([self.location.city isEqualToString:@"Addison"]);
}

- (void)testState
{
    XCTAssert([self.location.state isEqualToString:@"TX"]);
}

- (void)testFormattedAddress
{
    NSString *formattedAddress =  @"5100 Belt Line Road, STE 502 (Dallas North Tollway) Addison, TX 75254 United States";

    XCTAssert([self.location.formattedAddress isEqualToString:formattedAddress]);
}

@end