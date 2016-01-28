//
//  Restaurant.h
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "ParsableEntity.h"
@import Foundation;
@class Contact;
@class Location;

@interface Restaurant : NSObject <ParsableEntity>

@property (nonatomic, copy, nonnull) NSString *name;
@property (nonatomic, copy, nonnull) NSString *category;
@property (nonatomic, copy, nonnull) NSURL *backgroundImageURL;
@property (nonatomic, strong, nonnull) Contact *contact;
@property (nonatomic, strong, nonnull) Location *location;

@end