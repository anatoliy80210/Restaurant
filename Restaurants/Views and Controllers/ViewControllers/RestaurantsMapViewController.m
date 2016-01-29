//
//  RestaurantsMapViewController.m
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "AskForMapAuthorizationOperation.h"
#import "Location.h"
#import "Restaurant+MapAnnotation.h"
#import "Restaurant.h"
#import "RestaurantsMapViewController.h"

@import MapKit;

@interface RestaurantsMapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic, nullable) IBOutlet MKMapView *mapView;

@end

@implementation RestaurantsMapViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;

    AskForMapAuthorizationOperation *operation = [[AskForMapAuthorizationOperation alloc] init];
    operation.completionHandlerQueue = dispatch_get_main_queue();
    operation.completionHandler = ^(ConcurrentOperation *operation, NSArray<NSError *> *errors){
        [weakSelf.mapView addAnnotations:weakSelf.restaurants];
        [weakSelf focusMapAtCoordinate:weakSelf.restaurants.firstObject.coordinate];
    };

    [self.operationQueue addOperation:operation];
}

#pragma mark - IBAction

- (IBAction)didSelectStoresButton:(UIBarButtonItem *)sender
{
    [self focusMapAtCoordinate:self.restaurants.firstObject.coordinate];
}

- (IBAction)didSelectMeButton:(UIBarButtonItem *)sender
{
    [self focusMapAtCoordinate:self.mapView.userLocation.coordinate];
}

#pragma mark - MapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }

    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Restaurant"];

    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.canShowCallout = YES;
    annotationView.annotation = annotation;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([self.delegate respondsToSelector:@selector(restaurantMapController:didSelectRestaurant:)])
    {
        [self.delegate restaurantMapController:self didSelectRestaurant:(Restaurant *)view.annotation];
    }
}

#pragma mark - Helpers

- (void)focusMapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1));

    [self.mapView setRegion:region animated:YES];
}

@end