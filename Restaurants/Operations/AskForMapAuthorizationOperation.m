//
//  AskForMapAutorizationOperation.m
//  Restaurants
//
//  Created by Landron, Emil on 1/28/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "AskForMapAuthorizationOperation.h"
@import CoreLocation;

@interface AskForMapAuthorizationOperation () <CLLocationManagerDelegate>
@property (nonatomic, strong, nullable) CLLocationManager *locationManager;
@end

@implementation AskForMapAuthorizationOperation

- (void)execute
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    if (kCLAuthorizationStatusNotDetermined == status)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestWhenInUseAuthorization];
        [self finish];
    }
    else
    {
        [self finish];
    }
}

@end