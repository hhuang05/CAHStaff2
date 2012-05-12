//
//  CircleOfFifthsViewController.h
//  Staff
//
//  Created by Aaron Tietz on 4/30/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleView.h"


@interface CircleOfFifthsViewController : UIViewController{
    struct touchBox currentBox;
}

@property (nonatomic, retain) CircleView *content;
@property (nonatomic, retain) NSArray* boxesKey;
@property (nonatomic, retain) UIView* highlight;

- (UIView *)deepCopyCircleView:(UIView *)theView;
-(void)setUpBoxesKey;
-(int)getKeyForTouch:(UITouch*)touch;
-(void)highlightCurrentBox;
-(void)configureCurrentBox: (struct touchBox*)toCopy;

@end
