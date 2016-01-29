//
//  AskForMapAutorizationOperation.m
//  Restaurants
//
//  Created by Landron, Emil on 1/28/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "AskForMapAutorizationOperation.h"
@import CoreLocation;

@interface AskForMapAutorizationOperation () <CLLocationManagerDelegate>
@property (nonatomic, strong, nullable) CLLocationManager *locationManager;
@end

@implementation AskForMapAutorizationOperation

- (void)execute
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    if (kCLAuthorizationStatusNotDetermined == status)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
    }
    else
    {
        [self finish];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [super finish];
}

@end