//
//  ActivityIndicator.m
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

@import UIKit;
#import "ActivityIndicator.h"

@interface  ActivityIndicator ()
@property (nonatomic, assign) BOOL started;
@end

@implementation ActivityIndicator

static NSInteger gRunningIndicators = 0;

- (void)dealloc
{
    // In case finish was not called

    if (self.started)
    {
        gRunningIndicators--;
        [self validateNetworkIndicatorState];
    }
}

- (void)start
{
    if (self.started)
    {
        return;
    }

    self.started = YES;
    gRunningIndicators++;
    [self validateNetworkIndicatorState];
}

- (void)finish
{
    if (!self.started)
    {
        return;
    }

    self.started = NO;

    gRunningIndicators--;
    [self validateNetworkIndicatorState];
}

- (void)validateNetworkIndicatorState
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = gRunningIndicators != 0;
}

@end