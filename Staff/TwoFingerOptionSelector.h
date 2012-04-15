//
//  TwoFingerOptionSelector.h
//  Staff
//
//  Created by Aaron Tietz on 4/14/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoFingerOptionSelector : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UIView *TwoFingerOptionSelectorView;
    IBOutlet UIView *TwoFingerOptionsTab;
    IBOutlet UIPickerView *TwoFingerOptionPicker;
    NSArray *TwoFingerOptionsElements;
}

@property (nonatomic, retain) IBOutlet UIView *TwoFingerOptionSelectorView;
@property (nonatomic, retain) IBOutlet UIView *TwoFingerOptionsTab;
@property (nonatomic, retain) IBOutlet UIPickerView *TwoFingerOptionPicker;
@property (nonatomic, retain) NSArray *TwoFingerOptionsElements;

- (void)setup;
- (void)twoFingerOptionSelected:(UITapGestureRecognizer *)recognizer;
@end
