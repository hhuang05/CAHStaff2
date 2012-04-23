//
//  AccidentalsController.h
//  Staff
//
//  Created by Christopher Harris on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccidentalsController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *elements;
    UIView *content;
    IBOutlet UIPickerView *picker;
}

@property (nonatomic, retain) IBOutlet UIPickerView *picker;

@end
