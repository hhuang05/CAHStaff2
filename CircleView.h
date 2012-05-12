//
//  CircleView.h
//  Staff
//
//  Created by Aaron Tietz on 5/3/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>

struct touchBox {
    // four points: inner and outer clockwise right (on the circle)
    // inner and out clockwise left
    int outerCRX, outerCRY, innerCRX, innerCRY, 
    outerCLX, outerCLY, innerCLX, innerCLY;
    CGPoint center;
    float innerRadius, outerRadius;
    float startAngle, endAngle;
};

@interface CircleView : UIView
{
    double arctans[13];
    struct touchBox boxes[24];
}

-(void)hightlightBox:(int)boxnum;

-(struct touchBox*)returnBoxNum:(int)num;
-(float) returnArctanAtLocation:(int)location;

@end
