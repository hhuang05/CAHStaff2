//
//  AppDelegate.h
//  Staff
//
//  Created by Christopher Harris on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainController.h"
#import "crmd.h"

@class StaffController;

// sample MIDI app has NSObject, not UIResponder type
@interface AppDelegate : NSObject <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainController *viewController;

@property CRMD_HANDLE handle;

@property CRMD_FUNC *_api;

@property BOOL mix;

@end
