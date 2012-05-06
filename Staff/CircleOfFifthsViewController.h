//
//  CircleOfFifthsViewController.h
//  Staff
//
//  Created by Aaron Tietz on 4/30/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleView.h"


@interface CircleOfFifthsViewController : UIViewController

@property (nonatomic, retain) UIView *content;

- (UIView *)deepCopyCircleView:(UIView *)theView;

@end
