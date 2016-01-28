//
//  LoadImageOperation.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "LoadImageOperation.h"

@implementation LoadImageOperation

- (void)didDownloadDataAtURL:(NSURL *_Nonnull)fileURL
{
    NSData *data = [NSData dataWithContentsOfURL:fileURL];

    self.image = [UIImage imageWithData:data];
}

@end