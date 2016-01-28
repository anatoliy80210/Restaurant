//
//  NSNull+Utilities.h
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//
//  Abstract: This category will help to return nil when parsing entities
//

@import Foundation;

@interface NSNull (NSNull_Utilities)

- (id)objectForKeyedSubscript:(id)key;

@end