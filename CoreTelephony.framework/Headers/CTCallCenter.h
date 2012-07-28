/*
 *  CTCallCenter.h
 *  CFTelephony
 *
 *  Copyright 2010 Apple, Inc. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import <CoreTelephony/CoreTelephonyDefines.h>

@class CTCall;

CORETELEPHONY_CLASS_AVAILABLE(4_0)
@interface CTCallCenter : NSObject
{
@private
    void *_internal;

    NSSet *_currentCalls;
    void (^_callEventHandler)(CTCall *);
}

/*
 * currentCalls
 *
 * Discussion:
 *   An array containing CTCall objects for all calls that are currently
 *   in progress. If no calls are active, this will be nil.
 *   
 */
@property(readonly, retain) NSSet *currentCalls __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_0);

/*
 * callEventHandler
 *
 * Discussion:
 *   A block that will be dispatched on the default priority global dispatch
 *   queue when a new call event occurs. Set this property to a block
 *   that is defined in your application to handle call events.
 */
@property(nonatomic, copy) void (^callEventHandler)(CTCall*) __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_0);

@end
