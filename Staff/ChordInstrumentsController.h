//
//  ChordInstrumentsController.h
//  Staff
//
//  Created by Aaron Tietz on 5/1/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "AppDelegate.h"

@interface ChordInstrumentsController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *elements;
    UIView *content;
    int instrument;
    IBOutlet UIPickerView *picker;
}

@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property int instrument;

- (void)setupInstrumentsElements;
@end
