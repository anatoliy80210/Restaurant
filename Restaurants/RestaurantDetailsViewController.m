//
//  RestaurantDetailsViewController.m
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Contact.h"
#import "Location.h"
#import "Restaurant.h"
#import "RestaurantDetailsViewController.h"

@import MapKit;

@interface RestaurantDetailsViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;

@end

@implementation RestaurantDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.nameLabel.text = self.restaurant.name;
    self.categoryLabel.text = self.restaurant.category;
    self.addressLabel.text = self.restaurant.location.formattedAddress;
    self.phoneLabel.text = self.restaurant.contact.formattedPhone;
    self.twitterLabel.text = self.restaurant.contact.twitter;

    MKPointAnnotation *anotation = [[MKPointAnnotation alloc] init];
    anotation.title = self.restaurant.name;
    anotation.subtitle = self.restaurant.category;
    anotation.coordinate = CLLocationCoordinate2DMake(self.restaurant.location.latitude, self.restaurant.location.longitude);

    MKCoordinateRegion region = MKCoordinateRegionMake(anotation.coordinate, MKCoordinateSpanMake(0.005, 0.005));
    [self.mapView addAnnotation:anotation];
    [self.mapView setRegion:region animated:YES];
}

@end