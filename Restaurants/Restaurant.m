//
//  Restaurant.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Contact.h"
#import "Restaurant.h"
#import "Location.h"

@implementation Restaurant

#pragma mark - Dictionary Keys

static NSString *const kRestaurantNameKey = @"name";
static NSString *const kRestaurantBackgroundURLKey = @"backgroundImageURL";
static NSString *const kRestaurantCategoryKey = @"category";
static NSString *const kRestaurantContactKey = @"contact";
static NSString *const kRestaurantLocationKey = @"location";

#pragma mark - Init

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        NSString *backgroundURLString = dictionary[kRestaurantBackgroundURLKey];
        
        _name = dictionary[kRestaurantNameKey];
        _category = dictionary[kRestaurantCategoryKey];
        _backgroundImageURL = [[NSURL alloc]initWithString:backgroundURLString];
        
        NSDictionary *contactDictionary = dictionary[kRestaurantContactKey];
        _contact = [[Contact alloc] initWithDictionary:contactDictionary];
        
        NSDictionary *locationDictionary = dictionary[kRestaurantLocationKey];
        _location = [[Location alloc] initWithDictionary:locationDictionary];
    }
    
    return self;
}

@end
