//
//  sharpIcon.m
//  Staff
//
//  Created by Christopher Harris on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "sharpIcon.h"

@implementation sharpIcon

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float w, h;
    w = 200;
    h = 200;
    
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    CGAffineTransform myTextTransform; // 2
    CGContextSelectFont (myContext, // 3
                         "Helvetica-Bold",
                         h/10,
                         kCGEncodingMacRoman);
    CGContextSetCharacterSpacing (myContext, 10); // 4
    CGContextSetTextDrawingMode (myContext, kCGTextFillStroke); // 5
    
    CGContextSetRGBFillColor (myContext, 0, 1, 0, .5); // 6
    CGContextSetRGBStrokeColor (myContext, 0, 0, 1, 1); // 7
    //myTextTransform =  CGAffineTransformMakeRotation  (MyRadians (45)); // 8
    CGContextSetTextMatrix (myContext, myTextTransform); // 9
    CGContextShowTextAtPoint (myContext, 40, 0, "Quartz 2D", 9); 
}

@end
