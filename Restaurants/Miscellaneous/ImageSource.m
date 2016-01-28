//
//  ImageSource.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "ImageSource.h"
#import "LoadImageOperation.h"

@interface ImageSource ()
@property (nonatomic, strong, nonnull) UIImage *defaultImage;
@property (nonatomic, strong, nonnull) NSOperationQueue *operationQueue;
@property (nonatomic, strong, nonnull) NSMutableDictionary *loadedImagesDictionary;
@property (nonatomic, strong, nonnull) NSMutableDictionary *downloadingOperationsDictionary;
@end

@implementation ImageSource

- (instancetype)initWithDefaultImage:(UIImage *_Nonnull)defaultImage
{
    self = [super init];

    if (self)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        _loadedImagesDictionary = [NSMutableDictionary dictionary];
        _downloadingOperationsDictionary = [NSMutableDictionary dictionary];
        _defaultImage = defaultImage;
    }

    return self;
}

- (void)dealloc
{
    [self clearAllImages];
}

- (void)clearAllImages
{
    [self.operationQueue cancelAllOperations];
    [self.loadedImagesDictionary removeAllObjects];
    [self.downloadingOperationsDictionary removeAllObjects];
}

- (UIImage *_Nullable)imageForIndexPath:(NSIndexPath *_Nonnull)indexPath
{
    if (self.loadedImagesDictionary[indexPath])
    {
        return self.loadedImagesDictionary[indexPath];
    }

    return self.defaultImage;
}

- (void)willDisplayImageWithURL:(NSURL *_Nonnull)url atIndexPath:(NSIndexPath *_Nonnull)indexPath
{
    if (self.loadedImagesDictionary[indexPath] || self.downloadingOperationsDictionary[indexPath])
    {
        return;
    }

    __weak typeof(self) weakSelf = self;
    LoadImageOperation *operation = [[LoadImageOperation alloc]initWithURL:url];
    operation.completionHandlerQueue = dispatch_get_main_queue();
    operation.useCacheIfAvailable = YES;
    operation.completionHandler = ^void (ConcurrentOperation *operation, NSArray<NSError *> *errors){
        if (!errors)
        {
            LoadImageOperation *imageOperation = (LoadImageOperation *)operation;
            weakSelf.loadedImagesDictionary[indexPath] = imageOperation.image;

            if ([weakSelf.delegate respondsToSelector:@selector(imageSource:didLoadImageAtIndexPath:)])
            {
                [weakSelf.delegate imageSource:weakSelf didLoadImageAtIndexPath:indexPath];
            }
        }

        [weakSelf.downloadingOperationsDictionary removeObjectForKey:indexPath];
    };

    self.downloadingOperationsDictionary[indexPath] = operation;
    [self.operationQueue addOperation:operation];
}

- (void)didEndDisplayingImageAtIndexPath:(NSIndexPath *_Nonnull)indexPath
{
    LoadImageOperation *operation = self.downloadingOperationsDictionary[indexPath];

    [operation cancel];
    [self.downloadingOperationsDictionary removeObjectForKey:indexPath];
}

@end