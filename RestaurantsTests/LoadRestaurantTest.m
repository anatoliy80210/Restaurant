//
//  LoadRestaurantTest.m
//  Restaurants
//
//  Created by Landron, Emil on 1/28/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "LoadRestaurantsOperation.h"
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
@property (nonatomic, strong, nonnull) NSArray<Restaurant *> *loadedRestaurants;

@end

@implementation LoadRestaurantTest

- (void)setUp
{
    [super setUp];
    __weak typeof(self) weakSelf = self;

    XCTestExpectation *expectation = [self expectationWithDescription:@"LoadRestaurant"];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    LoadRestaurantsOperation *operation = (LoadRestaurantsOperation *)[[LoadRestaurantsOperationMockData alloc] init];
    operation.completionHandler = ^(ConcurrentOperation *operation, NSArray<NSError *> *errors){
        LoadRestaurantsOperationMockData *loadingOperation = (LoadRestaurantsOperationMockData *)operation;
        weakSelf.loadedRestaurants = loadingOperation.entities;

        [expectation fulfill];
    };

    [operationQueue addOperation:operation];

    [self waitForExpectationsWithTimeout:2 handler: ^(NSError *_Nullable error){
     }];

    NSLog(@"%@", self.loadedRestaurants);
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
}

- (void)testPerformanceExample
{
    [self measureBlock: ^{
         // Put the code you want to measure the time of here.
     }];
}

@end