//
//  ReporterBackendInteraction.m
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import "ReporterBackendInteraction.h"

@implementation ReporterBackendInteraction


+ (id)sharedManager {
    static ReporterBackendInteraction *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}



- (void) sendImageURLToBackend:(NSURL*) urlToImage {
    
    
    
}

@end
