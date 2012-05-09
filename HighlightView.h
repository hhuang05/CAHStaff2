//
//  HighlightView.h
//  Staff
//
//  Created by Aaron Tietz on 5/9/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleView.h"

@interface HighlightView : UIView{
    struct touchBox currentBox;
}

- (id)initWithFrame:(CGRect)frame AndPoints:(struct touchBox*)points;
-(void)highlightCurrentBox;

@end
