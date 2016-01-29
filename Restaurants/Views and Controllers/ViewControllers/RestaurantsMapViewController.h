//
//  RestaurantsMapViewController.h
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;
@class RestaurantsMapViewController;

@protocol RestaurantsMapViewControllerDelegate <NSObject>

- (void)restaurantMapController:(RestaurantsMapViewController *_Nonnull)controller didSelectRestaurant:(Restaurant *_Nonnull)restaurant;

@end

@interface RestaurantsMapViewController : UIViewController

@property (nonatomic, strong, nullable) NSArray<Restaurant *> *restaurants;
@property (nonatomic, weak, nullable) NSOperationQueue *operationQueue;
@property (nonatomic, weak, nullable) id<RestaurantsMapViewControllerDelegate> delegate;

@end