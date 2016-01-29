//
//  Restaurant+MapAnnotation.m
//  Restaurants
//
//  Created by Landron, Emil on 1/28/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Location.h"
#import "Restaurant+MapAnnotation.h"

@implementation Restaurant (MapAnnotation)

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return self.category;
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.location.latitude, self.location.longitude);
}

@end