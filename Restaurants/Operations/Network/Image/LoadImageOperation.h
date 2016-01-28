//
//  LoadImageOperation.h
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

@import UIKit;
#import "NetworkOperation.h"

@interface LoadImageOperation : NetworkOperation

@property (nonatomic, strong, nullable) UIImage *image;

@end