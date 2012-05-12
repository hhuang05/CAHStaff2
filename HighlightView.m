//
//  HighlightView.m
//  Staff
//
//  Created by Aaron Tietz on 5/9/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "HighlightView.h"
#import "CircleView.h"

@implementation HighlightView

- (id)initWithFrame:(CGRect)frame AndPoints:(struct touchBox*)points
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self configureCurrentBox:points];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [self highlightCurrentBox];
}

-(void)highlightCurrentBox{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextMoveToPoint(context, currentBox.outerCRX, currentBox.outerCRY);
    CGContextAddLineToPoint(context, currentBox.innerCRX, currentBox.innerCRY);
    CGContextAddLineToPoint(context, currentBox.innerCLX, currentBox.innerCLY);
    CGContextAddLineToPoint(context, currentBox.outerCLX, currentBox.outerCLY);
    CGContextAddLineToPoint(context, currentBox.outerCRX, currentBox.outerCRY);
    
    CGContextStrokePath(context);
}

-(void)configureCurrentBox: (struct touchBox*)toCopy{
    currentBox.innerCLX = toCopy->innerCLX;
    currentBox.innerCLY = toCopy->innerCLY;
    currentBox.innerCRX = toCopy->innerCRX;
    currentBox.innerCRY = toCopy->innerCRY;
    currentBox.outerCLX = toCopy->outerCLX;
    currentBox.outerCLY = toCopy->outerCLY;
    currentBox.outerCRX = toCopy->outerCRX;
    currentBox.outerCRY = toCopy->outerCRY;
}

@end
