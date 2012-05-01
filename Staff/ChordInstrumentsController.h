//
<<<<<<< HEAD
//  InstrumentsController.h
//  Staff
//
//  Created by Christopher Harris on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
=======
//  ChordInstrumentsController.h
//  Staff
//
//  Created by Aaron Tietz on 5/1/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

>>>>>>> temp
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
<<<<<<< HEAD

=======
>>>>>>> temp
@end
