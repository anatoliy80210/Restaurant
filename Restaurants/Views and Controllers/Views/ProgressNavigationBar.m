//
//  ProgressNavigationBar.m
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "ProgressNavigationBar.h"

@interface ProgressNavigationBar ()
@property (nonatomic, strong, nonnull) UIProgressView *progressView;
@end

@implementation ProgressNavigationBar

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        [self setupProgressView];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];

    if (self)
    {
        [self setupProgressView];
    }

    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupProgressView];
}

#pragma mark - Setters and Getters

- (CGFloat)progress
{
    return self.progressView.progress;
}

- (void)setProgress:(CGFloat)progress
{
    self.progressView.progress = progress;
    self.progressView.hidden = ((progress == 1) ||  (progress == 0));
}

#pragma mark - Helpers

- (void)setupProgressView
{
    [_progressView removeFromSuperview];

    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.translatesAutoresizingMaskIntoConstraints = NO;
    _progressView.tintColor = self.progressBarTintColor;

    [self addSubview:_progressView];

    NSDictionary *views = @{ @"progressView": _progressView };
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[progressView]-(0)-|" options:0 metrics:nil views:views];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[progressView(2)]-(0)-|" options:0 metrics:nil views:views];

    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];

    self.progress = 0;
}

@end