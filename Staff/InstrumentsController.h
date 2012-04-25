//
//  InstrumentsController.h
//  Staff
//
//  Created by Christopher Harris on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface InstrumentsController : UIViewController
{
    NSArray *elements;
    UIView *content;
    int instrument;
    IBOutlet UIPickerView *picker;
}

@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property int instrument;

@end
