//
//  CircleView.m
//  Staff
//
//  Created by Aaron Tietz on 5/3/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "CircleView.h"
#import <math.h>

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor grayColor];
        self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"circle_of_fifths.png"]];
        //self.backgroundColor = [UIColor clearColor];
        [self drawRect:frame];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    int outerX, outerY, middleX, middleY, innerX, innerY;
    int centerX = 275;
    int centerY = 275;
    int outerDiameter = 530;
    float outerRadius = outerDiameter / 2;
    int middleDiameter = 360;
    float middleRadius = middleDiameter / 2;
    int innerDiameter = 190;
    float innerRadius = innerDiameter / 2;
    CGPoint center = CGPointMake(centerX, centerY);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGRect outerCircle = CGRectMake(10,10,outerDiameter,outerDiameter);
    CGContextAddEllipseInRect(context, outerCircle);
    CGRect middleCircle = CGRectMake(95,95,middleDiameter,middleDiameter);
    CGContextAddEllipseInRect(context, middleCircle);
    CGRect innerCircle = CGRectMake(180,180,innerDiameter,innerDiameter);
    CGContextAddEllipseInRect(context, innerCircle);
    
    float multiplier = -1.5/12.0;
    
    for(int i = 0; i < 13; i++){
        outerX = (int)(centerX + (outerRadius * cos(multiplier * 2 * M_PI)));
        outerY = (int)(centerY + (outerRadius * sin(multiplier * 2 * M_PI)));
        middleX = (int)(centerX + (middleRadius * cos(multiplier * 2 * M_PI)));
        middleY = (int)(centerY + (middleRadius * sin(multiplier * 2 * M_PI))); 
        innerX = (int)(centerX + (innerRadius * cos(multiplier * 2 * M_PI)));
        innerY = (int)(centerY + (innerRadius * sin(multiplier * 2 * M_PI)));  
        
        double loc = atan2((outerY - 275),(outerX - 275));
        
        if(loc < 0){ 
            loc += 2 * M_PI;
        }
        
        arctans[i] = loc;
        
        //NSLog(@"using x,y : %d, %d", outerX, outerY);
        //NSLog(@"arctan: %f", arctans[i]);
        
        CGContextMoveToPoint(context, outerX, outerY);
        CGContextAddLineToPoint(context, middleX, middleY);
        
        CGContextMoveToPoint(context, middleX, middleY);
        CGContextAddLineToPoint(context, innerX, innerY);
        
        // we have the right most points of two boxes
        boxes[i].outerCRX = outerX;
        boxes[i].outerCRY = outerY;
        boxes[i].innerCRX = middleX;
        boxes[i].innerCRY = middleY;
        boxes[i].center = center;
        boxes[i].outerRadius = outerRadius;
        boxes[i].innerRadius = middleRadius;
        boxes[i].endAngle = loc;
            
        boxes[i + 13].outerCRX = middleX;
        boxes[i + 13].outerCRY = middleY;
        boxes[i + 13].innerCRX = innerX;
        boxes[i + 13].innerCRY = innerY;
        boxes[i + 13].center = center;
        boxes[i + 13].outerRadius = middleRadius;
        boxes[i + 13].innerRadius = innerRadius;
        boxes[i + 13].endAngle = loc;
        
        
        // and the leftmost points of two others
        if(i < 12){
            boxes[i + 1].outerCLX = outerX;
            boxes[i + 1].outerCLY = outerY;
            boxes[i + 1].innerCLX = middleX;
            boxes[i + 1].innerCLY = middleY;
            boxes[i + 1].startAngle = loc;
        
            boxes[i + 13 + 1].outerCLX = middleX;
            boxes[i + 13 + 1].outerCLY = middleY;
            boxes[i + 13 + 1].innerCLX = innerX;
            boxes[i + 13 + 1].innerCLY = innerY;
            boxes[i + 13+ 1].startAngle = loc;
        }
        else{
            boxes[0].outerCLX = outerX;
            boxes[0].outerCLY = outerY;
            boxes[0].innerCLX = middleX;
            boxes[0].innerCLY = middleY;
            boxes[0].startAngle = loc;
            
            boxes[13].outerCLX = middleX;
            boxes[13].outerCLY = middleY;
            boxes[13].innerCLX = innerX;
            boxes[13].innerCLY = innerY;
            boxes[13].startAngle = loc;
        }
        
        if( i == 4 || i == 5){
            multiplier += .5/12.0;
        }
        else{
            multiplier += 1.0/12.0;
        }
    }
    
    CGContextStrokePath(context);
}

-(float) returnArctanAtLocation:(int)location{
    return arctans[location];
}

-(struct touchBox*)returnBoxNum:(int)num{
    return &boxes[num];
}

-(void)hightlightBox:(int)boxnum{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    /*
     1 2
     3 4
     */
    
    // 1 -> 3 
    CGContextMoveToPoint(context, boxes[boxnum].outerCLX , boxes[boxnum].outerCLY);
    CGContextAddLineToPoint(context, boxes[boxnum].innerCLX , boxes[boxnum].innerCLY);
    
    // 1 -> 2
    CGContextMoveToPoint(context, boxes[boxnum].outerCLX , boxes[boxnum].outerCLY);
    CGContextAddLineToPoint(context, boxes[boxnum].outerCRX , boxes[boxnum].outerCRY);
    
    // 4 -> 3
    CGContextMoveToPoint(context, boxes[boxnum].innerCRY , boxes[boxnum].innerCRY);
    CGContextAddLineToPoint(context, boxes[boxnum].innerCLX , boxes[boxnum].innerCLY);
    
    // 4 -> 2
    CGContextMoveToPoint(context, boxes[boxnum].innerCRX , boxes[boxnum].innerCRY);
    CGContextAddLineToPoint(context, boxes[boxnum].outerCRX , boxes[boxnum].outerCRY);
     
}



@end
