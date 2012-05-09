//
//  CircleOfFifthsViewController.m
//  Staff
//
//  Created by Aaron Tietz on 4/30/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//
#import "CircleOfFifthsViewController.h"
#import "AppDelegate.h"
#import <math.h>

@implementation CircleOfFifthsViewController

@synthesize content = _content, boxesKey = _boxesKey;

-(id)init{
    self = [super init];
    if (self){
        _content = [[CircleView alloc] initWithFrame:[self.view frame]];
        [self.view addSubview:_content];
        [self setUpBoxesKey];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)setUpBoxesKey{
    _boxesKey = [[NSArray alloc] initWithObjects:
                 @"D", @"A", @"E", @"B", @"F#", @"Gb", @"Db", @"Ab", @"Eb", @"Bb", @"F",@"C", @"G", 
                 @"b", @"f#", @"c#", @"g#", @"d#", @"eb", @"bb", @"f", @"c", @"g", @"d", @"a", @"e", nil];
}

- (UIView *)deepCopyCircleView:(UIView *)theView
{
    CircleView *newView = [[CircleView alloc] initWithFrame:[theView frame]];
    [newView setBackgroundColor:[UIColor clearColor]];
    [newView setAlpha:0.5f];
    return newView;
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *allTouches = [touches allObjects];
    for(UITouch* t in allTouches){
        int location = [self getKeyForTouch:t];
        /*
        if(location -1 == -1){
            location = 12;
        }
        else if(location - 1 == 12){
            location = 25;
        }
        else{
            location--;
        }
         */
        if(location != -1){
            NSLog(@"touch in key: %@", [_boxesKey objectAtIndex:location]);
            AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
            [mainDelegate.viewController.dataController keySignatureWasChosen:[_boxesKey objectAtIndex:location]];
        }
    }
}

/*
 int centerX = 275;
 int centerY = 275;
 int outerDiameter = 530;
 float outerRadius = outerDiameter / 2;
 int middleDiameter = 360;
 float middleRadius = middleDiameter / 2;
 int innerDiameter = 190;
 float innerRadius = innerDiameter / 2;
 
 */

-(int)getKeyForTouch:(UITouch*)touch{
    int location = -1;

    float x = [touch locationInView:_content].x;
    float y = [touch locationInView:_content].y;
    
    double r = sqrt(((x-275)*(x-275)) + ((y-275)*(y-275)));
    
    double t = atan2((y-275),(x-275));
    if(t < 0){
        t += 2 * M_PI;
    }
    
    bool inner = (r <= 180 && r >= 90) ? true : false;
    bool outer = (r <= 270 && r > 180) ? true : false;
    
    for(int i = 0; i < 13; i++){
        int loc = (i + 1) < 12 ? (i + 1) : 0;
        
        if(t > [_content returnArctanAtLocation: i] && t < [_content returnArctanAtLocation:loc]){
            location = i;
            break;
        }
        if([_content returnArctanAtLocation:loc] < 1 && [_content returnArctanAtLocation:i] > 5.0){
            if (t <= [_content returnArctanAtLocation: loc] || t > [_content returnArctanAtLocation:i]){
                location = i;
                break;
            }
        }
    }
    
    if(outer && location != -1){
        return location;
    }
    
    if(inner && location != -1){
        return location + 13;
    }
    
    
/*    
    if(r <= 180 && r >= 90){
        for(int i = 0; i < 13; i++){
            if (i == 12){
                if( t > [_content returnArctanAtLocation:12] && t > [_content returnArctanAtLocation:0]){
                    return 14;
                }
                if([_content returnArctanAtLocation:12] < 1 && [_content returnArctanAtLocation:0] > 5.0){
                    if (t > [_content returnArctanAtLocation:12] || t <= [_content returnArctanAtLocation:0]){
                        return 14;
                    }
                }
            }
            else{
                if( t > [_content returnArctanAtLocation:i] && t < [_content returnArctanAtLocation:i + 1]){
                    return i + 13;
                }                
                if([_content returnArctanAtLocation:i + 1] < 1 && [_content returnArctanAtLocation:i] > 5.0){
                    if (t > [_content returnArctanAtLocation:i] || t <= [_content returnArctanAtLocation:i + 1]){
                        if(i == 11){
                            return 13;
                        }
                        else{
                            return i + 2 + 13;   
                        }
                    }
                }
            }
        }
    }
    
    if(r <= 270 && r >=180){
        for(int i = 0; i < 13; i++){
            if (i == 12){
                if( t > [_content returnArctanAtLocation:12] && t > [_content returnArctanAtLocation:0]){
                    return 1;
                }
                if([_content returnArctanAtLocation:12] < 1 && [_content returnArctanAtLocation:0] > 5.0){
                    if (t > [_content returnArctanAtLocation:12] || t <= [_content returnArctanAtLocation:0]){
                        return 1;
                    }
                }
            }
            else{
                if( t > [_content returnArctanAtLocation:i] && t < [_content returnArctanAtLocation:i + 1]){
                    if(i == 12){
                        return 1;
                    }
                    else if(i == 11){
                        return 0;
                    }
                    else{
                        return i + 2;   
                    }
                }                
                if([_content returnArctanAtLocation:i + 1] < 1 && [_content returnArctanAtLocation:i] > 5.0){
                    if (t > [_content returnArctanAtLocation:i] || t <= [_content returnArctanAtLocation:i + 1]){
                        if(i == 12){
                            return 1;
                        }
                        else if(i == 11){
                            return 0;
                        }
                        else{
                            return i + 2;   
                        }
                    }
                }
            }
        }
    }
    
 */
    return location;
}
    
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
    
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
    
@end

    
    /*
           
-(bool)touch:(UITouch*)touch IsInBox:(int)box{
    
    int x = [touch locationInView:_content].x;
    int y = [touch locationInView:_content].y;

    int outerCRX = [_content returnBoxNum:box]->outerCRX;
    int outerCRY = [_content returnBoxNum:box]->outerCRY;
    int innerCRX = [_content returnBoxNum:box]->innerCRX;
    int innerCRY = [_content returnBoxNum:box]->innerCRY;
    int outerCLX = [_content returnBoxNum:box]->outerCLX;
    int outerCLY = [_content returnBoxNum:box]->outerCLY;
    int innerCLX = [_content returnBoxNum:box]->innerCLX;
    int innerCLY = [_content returnBoxNum:box]->innerCLY;
    
    int maxX = [self getMaxOfOne:outerCLX AndTwo:outerCRX AndThree:innerCLX AndFour:innerCRX];
    int minX = [self getMinOfOne:outerCLX AndTwo:outerCRX AndThree:innerCLX AndFour:innerCRX];
    int maxY = [self getMaxOfOne:outerCLY AndTwo:outerCRY AndThree:innerCLY AndFour:innerCRY];
    int minY = [self getMinOfOne:outerCLY AndTwo:outerCRY AndThree:innerCLY AndFour:innerCRY];
    
    if((x >= minX && x <= maxX) && (y >= minY && y <= maxY)){
        NSLog(@"In box %d", box);
    }
    
    return ((x >= minX && x <= maxX) && (y >= minY && y <= maxY));
}

-(int)getMaxOfOne:(int)one AndTwo:(int)two AndThree:(int)three AndFour:(int)four{
    int maxOne = one > two ? one : two;
    int maxTwo = three > four ? three : four;
    
    return maxOne > maxTwo ? maxOne : maxTwo;
}

-(int)getMinOfOne:(int)one AndTwo:(int)two AndThree:(int)three AndFour:(int)four{
    int minOne = one < two ? one : two;
    int minTwo = three < four ? three : four;
    
    return minOne < minTwo ? minOne : minTwo;
}
*/

