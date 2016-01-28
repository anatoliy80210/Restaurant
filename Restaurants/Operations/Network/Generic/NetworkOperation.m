//
//  NetworkOperation.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "ActivityIndicator.h"
#import "NSString+Utilities.h"
#import "NetworkOperation.h"

@interface NetworkOperation () <NSURLSessionDownloadDelegate>

@property (nonatomic, strong, nonnull) ActivityIndicator *activityIndicator;
@property (nonatomic, strong, nonnull) NSFileManager *fileManager;
@property (nonatomic, strong, nonnull) NSURLRequest *urlRequest;
@property (nonatomic, strong, nullable) NSURL *cacheFileURL;
@property (nonatomic, strong, nullable) NSURLSessionDownloadTask *downloadTask;

@end

@implementation NetworkOperation

- (instancetype _Nonnull)initWithURL:(NSURL *_Nonnull)url
{
    self = [super init];

    if (self)
    {
        _urlRequest = [[NSURLRequest alloc] initWithURL:url];
        _activityIndicator = [[ActivityIndicator alloc] init];
        _fileManager = [NSFileManager defaultManager];
    }

    return self;
}

- (void)cancel
{
    [self.downloadTask cancel];
    [super cancel];
}

- (void)execute
{
    NSString *cacheName = self.urlRequest.URL.absoluteString.sha1;
    NSURL *cacheDirectory = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];

    self.cacheFileURL = [cacheDirectory URLByAppendingPathComponent:cacheName isDirectory:NO];

    if ([self isCacheAvailable] && !self.userInitiated && self.useCacheIfAvailable)
    {
        NSLog(@"Network (Cache): %@", self.urlRequest.URL);

        [self didDownloadDataAtURL:self.cacheFileURL];
        [self finish];
        return;
    }
    else
    {
        NSLog(@"Network (Server): %@", self.urlRequest.URL);
    }

    [self.activityIndicator start];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];

    self.downloadTask = [session downloadTaskWithRequest:self.urlRequest];
    [self.downloadTask resume];
}

- (void)didDownloadDataAtURL:(NSURL *_Nonnull)fileURL
{
    // Should be overwrite by subclasses
}

#pragma mark - NSURLSessionDownloadTask

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSURL *downloadURL = location;

    if (self.useCacheIfAvailable)
    {
        NSError *error = nil;
        [self.fileManager moveItemAtURL:downloadURL toURL:self.cacheFileURL error:&error];

        if (!error)
        {
            downloadURL = self.cacheFileURL;
        }
    }

    [self didDownloadDataAtURL:downloadURL];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    if (self.progressHandler)
    {
        CGFloat progress = (CGFloat)totalBytesWritten / totalBytesExpectedToWrite;

        if (self.completionHandlerQueue)
        {
            dispatch_async(self.completionHandlerQueue, ^{
                self.progressHandler(self, progress);
            });
        }
        else
        {
            self.progressHandler(self, progress);
        }
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error)
    {
        [self aggregateError:error];
    }

    [self.activityIndicator finish];
    [self finish];
}

#pragma mark - Helper

- (BOOL)isCacheAvailable
{
    return [[NSFileManager defaultManager] fileExistsAtPath:self.cacheFileURL.path];
}

@end