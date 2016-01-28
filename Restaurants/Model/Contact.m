//
//  Contact.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "Contact.h"

@implementation Contact

#pragma mark - Dictionary Keys

static NSString * const kContactPhoneKey = @"phone";
static NSString *const kContactFormattedPhoneKey = @"formattedPhone";
static NSString *const kContactTwitterKey = @"twitter";

#pragma mark - Init

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self)
    {
        _phone = dictionary[kContactPhoneKey];
        _formattedPhone = dictionary[kContactFormattedPhoneKey];
        _twitter = dictionary[kContactTwitterKey];
    }

    return self;
}

@end