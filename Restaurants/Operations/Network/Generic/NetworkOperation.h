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
typedef void (^NetworkOperationProgressHandler)(NetworkOperation *_Nonnull operation, CGFloat progress);

@interface NetworkOperation : ConcurrentOperation

@property (nonatomic, assign) BOOL useCacheIfAvailable;
@property (nonatomic, assign) BOOL userInitiated;
@property (nonatomic, strong, nullable) NetworkOperationProgressHandler progressHandler;

- (instancetype _Nonnull)initWithURL:(NSURL *_Nonnull)url;
- (void)didDownloadDataAtURL:(NSURL *_Nonnull)fileURL;

@end