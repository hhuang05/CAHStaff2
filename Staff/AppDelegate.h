//
//  AppDelegate.h
//  Staff
//
//  Created by Christopher Harris on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataController.h"
#import "MainController.h"

@class StaffController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainController *viewController;

@end
