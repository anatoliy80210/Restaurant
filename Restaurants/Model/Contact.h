//
//  Contact.h
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "ParsableEntity.h"
@import Foundation;

@interface Contact : NSObject <ParsableEntity>

@property (nonatomic, copy, nonnull) NSString *phone;
@property (nonatomic, copy, nonnull) NSString *formattedPhone;
@property (nonatomic, copy, nonnull) NSString *twitter;

@end