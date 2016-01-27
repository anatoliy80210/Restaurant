//
//  ConcurrentOperation.h
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

@import Foundation;

@class ConcurrentOperation;

typedef void (^ConcurrentOperationHandler)(ConcurrentOperation *_Nonnull, NSArray<NSError *> *_Nullable);

@interface ConcurrentOperation : NSOperation

@property (nonatomic, strong, nullable) ConcurrentOperationHandler completionHandler;
@property (nonatomic, strong, nullable) dispatch_queue_t completionHandlerQueue;

- (void)aggregateError:(NSError *_Nonnull)error;
- (void)execute;
- (void)finish;

@end
