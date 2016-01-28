//
//  Location.h
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

@import Foundation;
@import CoreGraphics;

#import "ParsableEntity.h"

@interface Location : NSObject<ParsableEntity>

@property (nonatomic, copy, nonnull) NSString *address;
@property (nonatomic, copy, nonnull) NSString *crossStreet;
@property (nonatomic, copy, nonnull) NSString *postalCode;
@property (nonatomic, copy, nonnull) NSString *country;
@property (nonatomic, copy, nonnull) NSString *countryCode;
@property (nonatomic, copy, nonnull) NSString *state;
@property (nonatomic, copy, nonnull) NSString *city;
@property (nonatomic, copy, nonnull) NSString *formattedAddress;

@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

@end