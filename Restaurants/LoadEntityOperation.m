//
//  LoadEntityOperation.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "LoadEntityOperation.h"

@interface LoadEntityOperation ()
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, assign) Class entityClass;

@end

@implementation LoadEntityOperation

- (instancetype)initWithURL:(NSURL *)url keyPath:(NSString *)keyPath entityClass:(Class)entityClass {
    self = [super initWithURL:url];
    
    if (self) {
        self.keyPath = keyPath;
        self.entityClass = entityClass;
    }
    
    return self;
}

- (void)didDownloadDataAtURL:(NSURL *)fileURL {
    NSAssert(self.keyPath, @"LoadEntityOperation cannot parse without a KeyPath");
    
    NSData *data = [NSData dataWithContentsOfURL:fileURL];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *jsonArray = jsonDictionary[self.keyPath];
    
    NSMutableArray *parsedEntities = [NSMutableArray arrayWithCapacity:jsonArray.count];
    
    for (NSDictionary *dictionary in jsonArray) {
        [parsedEntities addObject:[[self.entityClass alloc] initWithDictionary:dictionary]];
    }
    
    self.entities = [parsedEntities copy];    
}

@end
