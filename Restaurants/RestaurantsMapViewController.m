//
//  RestaurantsMapViewController.m
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "RestaurantsMapViewController.h"
#import "Restaurant.h"
#import "Location.h"

@import MapKit;

@interface RestaurantsMapViewController()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation RestaurantsMapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray<MKPointAnnotation*> *anotations = [NSMutableArray arrayWithCapacity:self.restaurants.count];
    
    for (Restaurant *restaurant in self.restaurants) {
        MKPointAnnotation *anotation = [[MKPointAnnotation alloc] init];
        anotation.title = restaurant.name;
        anotation.subtitle = restaurant.category;
        anotation.coordinate = CLLocationCoordinate2DMake(restaurant.location.latitude, restaurant.location.longitude);
        [anotations addObject:anotation];
    }
    
    MKCoordinateRegion region = MKCoordinateRegionMake(anotations.firstObject.coordinate, MKCoordinateSpanMake(0.1, 0.1));
    
    [self.mapView addAnnotations:anotations];
    [self.mapView setRegion:region animated:YES];
    
}

@end
