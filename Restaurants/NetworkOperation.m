//
//  NetworkOperation.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "NetworkOperation.h"
#import "ActivityIndicator.h"


@interface NetworkOperation () <NSURLSessionDownloadDelegate>

@property (nonatomic, copy, nonnull) NSURLRequest *urlRequst;
@property (nonatomic, strong, nonnull) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong, nonnull) ActivityIndicator *activiyIndicator;

@end

@implementation NetworkOperation

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    
    if (self) {
        _urlRequst = [[NSURLRequest alloc] initWithURL:url];
        _activiyIndicator = [[ActivityIndicator alloc] init];
    }
    
    return self;
}

- (void)cancel {
    [self.downloadTask cancel];
    [super cancel];
}

- (void)execute {
    
    NSLog(@"Network: %@", self.urlRequst.URL);
        
    [self.activiyIndicator start];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    self.downloadTask = [session downloadTaskWithRequest: self.urlRequst];
    [self.downloadTask resume];
}

- (void)didDownloadDataAtURL:(NSURL *)fileURL {
}

#pragma mark - NSURLSessionDownloadTask


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    [self didDownloadDataAtURL:location];
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {

    if (self.progressHandler) {
        CGFloat progress = (CGFloat)totalBytesWritten / totalBytesExpectedToWrite;
        if (self.completionHandlerQueue) {
            dispatch_async(self.completionHandlerQueue, ^{
                self.progressHandler(self, progress);
            });
        }
        else {
            self.progressHandler(self, progress);
        }
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        [self aggregateError:error];
    }
    
    [self.activiyIndicator finish];
    [self finish];
}

@end
