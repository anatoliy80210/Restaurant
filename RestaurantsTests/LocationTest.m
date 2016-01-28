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
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAddress
{
    XCTAssertEqual(self.location.address, @"some address");
}

- (void)testCrossStreet
{
    XCTAssertEqual(self.location.crossStreet, @"some crossStreet");
}

- (void)testLatitude
{
    XCTAssertEqual(self.location.latitude, 113.311);
}

- (void)testLongitude
{
    XCTAssertEqual(self.location.longitude, -1543.3333);
}

- (void)testPostalCode
{
    XCTAssertEqual(self.location.postalCode, @"76210");
}

- (void)testCountryCode
{
    XCTAssertEqual(self.location.countryCode, @"US");
}

- (void)testCountry
{
    XCTAssertEqual(self.location.country, @"United States");
}

- (void)testCity
{
    XCTAssertEqual(self.location.city, @"Plano");
}

- (void)testState
{
    XCTAssertEqual(self.location.state, @"TX");
}

- (void)testFormattedAddress
{
    NSString *formattedAddress =  @"Number Street Plano TX United States";

    XCTAssertEqual(self.location.formattedAddress, formattedAddress);
}

@end