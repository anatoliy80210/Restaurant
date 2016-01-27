//
//  WebBrowserViewController.m
//  Restaurants
//
//  Created by Emil Landron on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "WebBrowserViewController.h"
#import "ProgressNavigationBar.h"
#import "ActivityIndicator.h"

@import WebKit;

@interface WebBrowserViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButtonItem;

@property (strong, nonatomic) ActivityIndicator *activityIndicator;

@end

@implementation WebBrowserViewController

#pragma mark - static

static NSString * const kInitialURLString = @"http://www.bottlerocketstudios.com";
static NSString * const kWebViewProgressKeyPath = @"estimatedProgress";
static NSString * const kWebViewCanGoBackKeyPath = @"canGoBack";
static NSString * const kWebViewCanGoForwardKeyPath = @"canGoForward";
static NSString * const kWebViewReloadingKeyPath = @"loading";
static NSString * const kWebViewTitleKeyPath = @"title";

#pragma mark - Life Cycle

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:kWebViewProgressKeyPath];
    [self.webView removeObserver:self forKeyPath:kWebViewCanGoBackKeyPath];
    [self.webView removeObserver:self forKeyPath:kWebViewCanGoForwardKeyPath];
    [self.webView removeObserver:self forKeyPath:kWebViewReloadingKeyPath];
    [self.webView removeObserver:self forKeyPath:kWebViewTitleKeyPath];
}

-(void)loadView {
    
    WKWebView *webView = [[WKWebView alloc] init];
    [webView addObserver:self forKeyPath:kWebViewProgressKeyPath options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:kWebViewCanGoBackKeyPath options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:kWebViewCanGoForwardKeyPath options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:kWebViewReloadingKeyPath options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:kWebViewTitleKeyPath options:NSKeyValueObservingOptionNew context:nil];

    self.view = webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self validateNavigationButtonStates];
    
    self.activityIndicator = [[ActivityIndicator alloc] init];
    
    NSURL *initialURL = [[NSURL alloc] initWithString:kInitialURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:initialURL];

    [self.webView loadRequest:request];
}


#pragma mark - IBActions

- (IBAction)didSelectBackButton:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)didSelectRefreshButton:(UIBarButtonItem *)sender {
    [self.webView reload];
}

- (IBAction)didSelectForwardButton:(UIBarButtonItem *)sender {
    [self.webView goForward];
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if ([keyPath isEqualToString:kWebViewProgressKeyPath] && object == self.webView) {
        
        ProgressNavigationBar *bar = (ProgressNavigationBar*)self.navigationController.navigationBar;
        bar.progress = self.webView.estimatedProgress;
    }
    else if ([keyPath isEqualToString:kWebViewTitleKeyPath]) {
        self.navigationItem.title = self.webView.title;
    }
    else if ([keyPath isEqualToString:kWebViewCanGoBackKeyPath] || [keyPath isEqualToString:kWebViewCanGoForwardKeyPath] || [keyPath isEqualToString:kWebViewReloadingKeyPath]) {
        [self validateNavigationButtonStates];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Helper

- (void)validateNavigationButtonStates {
    self.backButtonItem.enabled = self.webView.canGoBack;
    self.forwardButtonItem.enabled = self.webView.canGoForward;
    self.refreshButtonItem.enabled = !self.webView.loading;
    
    if (self.webView.loading) {
        [self.activityIndicator start];
    }
    else {
        [self.activityIndicator finish];
    }
    
}

-(WKWebView *)webView {
    return (WKWebView*)self.view;
}


@end
