//
//  LoadRestaurantTest.m
//  Restaurants
//
//  Created by Landron, Emil on 1/28/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Contact.h"
#import "LoadRestaurantsOperation.h"
#import "Location.h"
#import "Restaurant.h"

@import XCTest;

#pragma mark - LoadRestaurantsOperationMockData

@interface LoadRestaurantsOperationMockData : LoadRestaurantsOperation
@end

@implementation LoadRestaurantsOperationMockData

- (void)execute
{
    NSURL *localJsonURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"RestaurantsMock" withExtension:@".json"];

    [self didDownloadDataAtURL:localJsonURL];
    [self finish];
}

@end

#pragma mark - LoadRestaurantTest

@interface LoadRestaurantTest : XCTestCase
@property (nonatomic, strong, nonnull) Restaurant *restaurantToTest;
@property (nonatomic, strong, nonnull) Restaurant *loadedRestaurant;
@end

@implementation LoadRestaurantTest

- (void)setUp
{
    [super setUp];
    __weak typeof(self) weakSelf = self;

    XCTestExpectation *expectation = [self expectationWithDescription:@"LoadRestaurant"];
    NSURL *localJsonURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"RestaurantsMock" withExtension:@".json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:localJsonURL];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSDictionary *restaurantDictionary = jsonDictionary[@"restaurants"][0];

    self.loadedRestaurant = [[Restaurant alloc] initWithDictionary:restaurantDictionary];

    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    LoadRestaurantsOperation *operation = (LoadRestaurantsOperation *)[[LoadRestaurantsOperationMockData alloc] init];
    operation.completionHandler = ^(ConcurrentOperation *operation, NSArray<NSError *> *errors){
        LoadRestaurantsOperationMockData *loadingOperation = (LoadRestaurantsOperationMockData *)operation;
        weakSelf.restaurantToTest = loadingOperation.entities.firstObject;

        [expectation fulfill];
    };

    [operationQueue addOperation:operation];

    [self waitForExpectationsWithTimeout:2 handler: ^(NSError *_Nullable error){
     }];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testRestaurants
{
    XCTAssert([self.restaurantToTest.name isEqualToString:self.loadedRestaurant.name]);
    XCTAssert([self.restaurantToTest.category isEqualToString:self.loadedRestaurant.category]);
    XCTAssert([self.restaurantToTest.backgroundImageURL.absoluteString isEqualToString:self.loadedRestaurant.backgroundImageURL.absoluteString]);

    XCTAssert([self.restaurantToTest.contact.phone isEqualToString:self.loadedRestaurant.contact.phone]);
    XCTAssert([self.restaurantToTest.contact.formattedPhone isEqualToString:self.loadedRestaurant.contact.formattedPhone]);
    XCTAssert([self.restaurantToTest.contact.twitter isEqualToString:self.loadedRestaurant.contact.twitter]);

    XCTAssert([self.restaurantToTest.location.address isEqualToString:self.loadedRestaurant.location.address]);
    XCTAssert([self.restaurantToTest.location.crossStreet isEqualToString:self.loadedRestaurant.location.crossStreet]);
    XCTAssert([self.restaurantToTest.location.postalCode isEqualToString:self.loadedRestaurant.location.postalCode]);
    XCTAssert([self.restaurantToTest.location.country isEqualToString:self.loadedRestaurant.location.country]);
    XCTAssert([self.restaurantToTest.location.countryCode isEqualToString:self.loadedRestaurant.location.countryCode]);
    XCTAssert([self.restaurantToTest.location.state isEqualToString:self.loadedRestaurant.location.state]);
    XCTAssert([self.restaurantToTest.location.city isEqualToString:self.loadedRestaurant.location.city]);
    XCTAssert([self.restaurantToTest.location.formattedAddress isEqualToString:self.loadedRestaurant.location.formattedAddress]);

    XCTAssertEqual(self.restaurantToTest.location.longitude, self.loadedRestaurant.location.longitude);
    XCTAssertEqual(self.restaurantToTest.location.latitude, self.loadedRestaurant.location.latitude);
}

@end