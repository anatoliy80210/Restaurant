//
//  ConcurrentOperation.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "ConcurrentOperation.h"

#pragma mark - Types

typedef enum : NSUInteger {
    ConcurrentOperationStateReady,
    ConcurrentOperationStateExecuting,
    ConcurrentOperationStateFinished,
} ConcurrentOperationState;


#pragma mark - ConcurrentOperation Interface

@interface ConcurrentOperation ()
@property (nonatomic, assign) ConcurrentOperationState state;
@property (nonatomic, strong) NSMutableArray<NSError *> *errors;

@end

#pragma mark - ConcurrentOperation Implementation

@implementation ConcurrentOperation

#pragma mark - Overwrite

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.state = ConcurrentOperationStateReady;
    }
    
    return self;
}

- (void)start {
    [super start];
    
    if (self.cancelled) {
        [self finish];
        return;
    }
}

- (void)main {
    NSAssert(ConcurrentOperationStateReady == self.state, @"This operation must be performed on an operation queue.");
    
    if (self.cancelled) {
        [self finish];
        return;
    }
    
    self.state = ConcurrentOperationStateExecuting;
    [self execute];
}

- (void)cancel {
    
    NSError *error = [NSError errorWithDomain:@"ConcurrentOperation" code:999999 userInfo:nil];
    [self aggregateError:error];
    
    [self finish];
}

#pragma mark - Public

- (void)aggregateError:(NSError *_Nonnull)error {
    if (!self.errors) {
        self.errors = [NSMutableArray arrayWithCapacity:1];
    }
    
    [self.errors addObject:error];
}

- (void)execute {
    [self finish];
}

- (void)finish {
    if (self.completionHandler) {
        if (self.completionHandlerQueue) {
            dispatch_async(self.completionHandlerQueue, ^{
                self.completionHandler(self, self.errors);
                self.state = ConcurrentOperationStateFinished;
            });
        }
        else {
            self.completionHandler(self, self.errors);
            self.state = ConcurrentOperationStateFinished;
        }
    }
}

#pragma mark - Getters

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isReady {
    return super.ready && (self.state == ConcurrentOperationStateReady);
}

- (BOOL)isExecuting {
    return self.state == ConcurrentOperationStateExecuting;
}

- (BOOL)isFinished {
    return self.state == ConcurrentOperationStateFinished;
}

#pragma mark - Setters

- (void)setState:(ConcurrentOperationState)state {
    NSString *oldKeyPath = [self keyPathForState:self.state];
    NSString *newKeyPath = [self keyPathForState:state];
    
    [self willChangeValueForKey:newKeyPath];
    [self willChangeValueForKey:oldKeyPath];
    
    _state = state;
    
    [self didChangeValueForKey:oldKeyPath];
    [self didChangeValueForKey:newKeyPath];
}

#pragma mark - Helpers

- (NSString *)keyPathForState:(ConcurrentOperationState)state  {
    NSString *keyPath = nil;
    
    switch (state) {
        case ConcurrentOperationStateReady:
            keyPath = @"isReady";
            break;
            
        case ConcurrentOperationStateExecuting:
            keyPath = @"isExecuting";
            break;
            
        case ConcurrentOperationStateFinished:
            keyPath = @"isFinished";
            break;
    }
    return keyPath;
}

@end
