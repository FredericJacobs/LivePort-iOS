//
//  ReporterBackendInteraction.h
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReporterBackendInteraction : NSObject{
    NSString *selectedString;
}

@property (nonatomic,retain) NSString *selectedString;

+ (id)sharedManager;
- (void) sendImageURLToBackend:(NSURL*) urlToImage;


@end
