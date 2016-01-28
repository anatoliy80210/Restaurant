//
//  NetworkOperation.h
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

@import Foundation;
@import CoreGraphics;

#import "ConcurrentOperation.h"

@class NetworkOperation;
typedef void (^NetworkOperationProgressHandler)(NetworkOperation *operation, CGFloat progress);

@interface NetworkOperation : ConcurrentOperation

@property (nonatomic, assign) BOOL useCacheIfAvailable;
@property (nonatomic, strong) NetworkOperationProgressHandler progressHandler;

- (instancetype)initWithURL:(NSURL *)url;
- (void)didDownloadDataAtURL:(NSURL *)fileURL;

@end