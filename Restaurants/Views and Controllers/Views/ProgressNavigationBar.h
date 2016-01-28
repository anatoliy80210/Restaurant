//
//  ProgressNavigationBar.h
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

@import UIKit;

@interface ProgressNavigationBar : UINavigationBar
@property (nonatomic, strong, nonnull) IBInspectable UIColor *progressBarTintColor;
@property (assign, nonatomic) CGFloat progress;

@end