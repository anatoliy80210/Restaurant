//
//  Location.m
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Location.h"

@implementation Location

#pragma mark - Dictionary Keys

static NSString *const kLocationAddressKey = @"address";
static NSString *const kLocationCrossStreetKey = @"crossStreet";
static NSString *const kLocationLatitudeKey = @"lat";
static NSString *const kLocationLongitudeKey = @"lng";
static NSString *const kLocationPostalCodeKey = @"postalCode";
static NSString *const kLocationCountryCodeKey = @"cc";
static NSString *const kLocationCityKey = @"city";
static NSString *const kLocationStateKey = @"state";
static NSString *const kLocationCountryKey = @"country";
static NSString *const kLocationFormattedAddressKey = @"formattedAddress";


#pragma mark - Init

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.address = dictionary[kLocationAddressKey];
        self.crossStreet = dictionary[kLocationCrossStreetKey];
        self.postalCode = dictionary[kLocationPostalCodeKey];
        self.country = dictionary[kLocationCountryKey];
        self.countryCode = dictionary[kLocationCountryCodeKey];
        self.state = dictionary[kLocationStateKey];
        self.city = dictionary[kLocationCityKey];
       
        self.latitude = [dictionary[kLocationLatitudeKey] doubleValue];
        self.longitude = [dictionary[kLocationLongitudeKey] doubleValue];

        NSArray *addresses = dictionary[kLocationFormattedAddressKey];
        self.formattedAddress = [addresses componentsJoinedByString:@" "];
    }
    
    return self;
}

@end
