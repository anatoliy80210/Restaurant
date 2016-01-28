//
//  RestaurantsMapViewController.m
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Location.h"
#import "Restaurant.h"
#import "RestaurantsMapViewController.h"

@import MapKit;

@interface RestaurantsMapViewController ()
@property (weak, nonatomic, nullable) IBOutlet MKMapView *mapView;

@end

@implementation RestaurantsMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray<MKPointAnnotation *> *annotations = [NSMutableArray arrayWithCapacity:self.restaurants.count];

    for (Restaurant *restaurant in self.restaurants)
    {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.title = restaurant.name;
        annotation.subtitle = restaurant.category;
        annotation.coordinate = CLLocationCoordinate2DMake(restaurant.location.latitude, restaurant.location.longitude);
        [annotations addObject:annotation];
    }

    MKCoordinateRegion region = MKCoordinateRegionMake(annotations.firstObject.coordinate, MKCoordinateSpanMake(0.1, 0.1));

    [self.mapView addAnnotations:annotations];
    [self.mapView setRegion:region animated:YES];
}

@end