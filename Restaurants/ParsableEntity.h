//
//  ParsableEntity.h
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

@import Foundation;

@protocol ParsableEntity <NSObject>

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
