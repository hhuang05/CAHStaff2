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

@property (nonatomic, retain) CircleView *content;
@property (nonatomic, retain) NSArray* boxesKey;

- (UIView *)deepCopyCircleView:(UIView *)theView;
-(void)setUpBoxesKey;
-(int)getKeyForTouch:(UITouch*)touch;
/*
-(bool)touch:(UITouch*)touch IsInBox:(int)box;
-(int)getMaxOfOne:(int)one AndTwo:(int)two AndThree:(int)three AndFour:(int)four;
-(int)getMinOfOne:(int)one AndTwo:(int)two AndThree:(int)three AndFour:(int)four;
 */

@end
