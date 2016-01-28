//
//  LoadRestaurantsOperation.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "LoadRestaurantsOperation.h"
#import "Restaurant.h"

@implementation LoadRestaurantsOperation

- (instancetype)init
{
    NSURL *url = [NSURL URLWithString:@"http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"];

    self = [super initWithURL:url keyPath:@"restaurants" entityClass:[Restaurant class]];

    if (self)
    {
        self.useCacheIfAvailable = YES;
    }

    return self;
}

@end