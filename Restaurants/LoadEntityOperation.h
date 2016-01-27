//
//  LoadEntityOperation.h
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

@import Foundation;
#import "NetworkOperation.h"
#import "ParsableEntity.h"

@interface LoadEntityOperation : NetworkOperation

@property (nonatomic, strong) NSArray *entities;

- (instancetype)initWithURL:(NSURL *)url keyPath:(NSString *)keyPath entityClass:(Class)entityClass;

@end
