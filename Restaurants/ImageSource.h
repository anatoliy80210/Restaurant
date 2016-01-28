//
//  ImageSource.h
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

@import UIKit;
@class ImageSource;

@protocol ImageSourceDelegate <NSObject>
- (void)imageSource:(ImageSource *_Nonnull)imageSource didLoadImageAtIndexPath:(NSIndexPath *_Nonnull)indexPath;
@end

@interface ImageSource : NSObject
@property (nonatomic, weak, nullable) id<ImageSourceDelegate> delegate;

- (instancetype _Nonnull)initWithDefaultImage:(UIImage *_Nonnull)defaultImage;
- (void)clearAllImages;
- (UIImage *_Nullable)imageForIndexPath:(NSIndexPath *_Nonnull)indexPath;
- (void)willDisplayImageWithURL:(NSURL *_Nonnull)url atIndexPath:(NSIndexPath *_Nonnull)indexPath;
- (void)didEndDisplayingImageAtIndexPath:(NSIndexPath *_Nonnull)indexPath;

@end