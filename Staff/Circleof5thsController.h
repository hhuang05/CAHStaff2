//
//  Circleof5thsController.h
//  Staff
//
//  Created by Christopher Harris on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Circleof5thsController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UIView *circleOf5thsView;
    IBOutlet UIView *circleOf5thsTab;
    IBOutlet UIPickerView *circleOf5thsPicker;
    NSArray *circleOf5thsPickerElements;
}

@property (nonatomic, retain) IBOutlet UIView *circleOf5thsView;
@property (nonatomic, retain) IBOutlet UIView *circleOf5thsTab;
@property (nonatomic, retain) IBOutlet UIPickerView *circleOf5thsPicker;
<<<<<<< HEAD
@property NSArray *circleOf5thsPickerElements;
=======
@property (nonatomic, retain) IBOutlet UIButton *circleOf5thsButton;
@property (retain) NSArray *circleOf5thsPickerElements;
>>>>>>> 5bc7e90170fb30c48fce32f36763a6209b1081b8

- (void)setup;
- (void)circleOf5thsTabTapped:(UITapGestureRecognizer *)recognizer;
@end
