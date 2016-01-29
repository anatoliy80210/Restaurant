//
//  RestaurantDetailsViewController.m
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Contact.h"
#import "Location.h"
#import "Restaurant+MapAnnotation.h"
#import "Restaurant.h"
#import "RestaurantDetailsViewController.h"

@import MapKit;

@interface RestaurantDetailsViewController ()

@property (weak, nonatomic, nullable) IBOutlet MKMapView *mapView;
@property (weak, nonatomic, nullable) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *twitterLabel;

@end

@implementation RestaurantDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.nameLabel.text = self.restaurant.name;
    self.categoryLabel.text = self.restaurant.category;
    self.addressLabel.text = self.restaurant.location.formattedAddress;
    self.phoneLabel.text = self.restaurant.contact.formattedPhone;
    self.twitterLabel.text =  self.restaurant.contact.twitter ? [NSString stringWithFormat:@"@%@", self.restaurant.contact.twitter] : nil;

    [self.mapView addAnnotation:self.restaurant];

    MKCoordinateRegion region = MKCoordinateRegionMake(self.restaurant.coordinate, MKCoordinateSpanMake(0.005, 0.005));
    [self.mapView setRegion:region animated:NO];
}

@end