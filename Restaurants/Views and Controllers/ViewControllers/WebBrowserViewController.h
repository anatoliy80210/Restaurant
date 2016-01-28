//
//  WebBrowserViewController.h
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

@import UIKit;
@class WKWebView;

@interface WebBrowserViewController : UIViewController
@property (strong, nonatomic, readonly) WKWebView *webView;

@end