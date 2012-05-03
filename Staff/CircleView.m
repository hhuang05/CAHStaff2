//
//  CircleView.m
//  Staff
//
//  Created by Aaron Tietz on 5/3/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self drawRect:frame];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGRect rectangle = CGRectMake(0,0,500,500);
    
    CGContextAddEllipseInRect(context, rectangle);
    
    CGContextStrokePath(context);}


@end
