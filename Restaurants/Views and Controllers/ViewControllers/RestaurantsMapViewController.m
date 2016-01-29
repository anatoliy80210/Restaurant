//
//  RestaurantsMapViewController.m
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "AskForMapAutorizationOperation.h"
#import "Location.h"
#import "Restaurant.h"
#import "RestaurantsMapViewController.h"

@import MapKit;

@interface RestaurantsMapViewController ()
@property (weak, nonatomic, nullable) IBOutlet MKMapView *mapView;

@end

@implementation RestaurantsMapViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;

    AskForMapAutorizationOperation *operation = [[AskForMapAutorizationOperation alloc] init];
    operation.completionHandlerQueue = dispatch_get_main_queue();
    operation.completionHandler = ^(ConcurrentOperation *operation, NSArray<NSError *> *errors){
        NSMutableArray<MKPointAnnotation *> *annotations = [NSMutableArray arrayWithCapacity:weakSelf.restaurants.count];

        for (Restaurant *restaurant in weakSelf.restaurants)
        {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.title = restaurant.name;
            annotation.subtitle = restaurant.category;
            annotation.coordinate = CLLocationCoordinate2DMake(restaurant.location.latitude, restaurant.location.longitude);
            [annotations addObject:annotation];
        }

        [weakSelf.mapView addAnnotations:annotations];
        [weakSelf focusMapAtCoordinate:annotations.firstObject.coordinate];
    };

    [self.operationQueue addOperation:operation];
}

#pragma mark - IBAction

- (IBAction)didSelectStoresButton:(UIBarButtonItem *)sender
{
    Restaurant *restaurant = self.restaurants.firstObject;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(restaurant.location.latitude, restaurant.location.longitude);

    [self focusMapAtCoordinate:coordinate];
}

- (IBAction)didSelectMeButton:(UIBarButtonItem *)sender
{
    [self focusMapAtCoordinate:self.mapView.userLocation.coordinate];
}

#pragma mark - Helpers

- (void)focusMapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1));

    [self.mapView setRegion:region animated:YES];
}

@end