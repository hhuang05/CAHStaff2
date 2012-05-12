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
#import "HighlightView.h"

@implementation CircleOfFifthsViewController

@synthesize content = _content, boxesKey = _boxesKey, highlight = _highlight;

-(id)init{
    self = [super init];
    if (self){
        _content = [[CircleView alloc] initWithFrame:[self.view frame]];
        [self.view addSubview:_content];
        [self setUpBoxesKey];
        [self configureCurrentBox:[_content returnBoxNum:11]];
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
        
        if(location != -1){
            NSLog(@"circle location == %d", location);
            [_highlight removeFromSuperview];
            int highlightLocation;
            if(location < 13){
                highlightLocation = location + 1 < 13 ? location + 1 : 0;
            }
            else{
                highlightLocation = location + 1 < 26 ? location + 1 : 13;
            }
            [self configureCurrentBox:[_content returnBoxNum:highlightLocation]];
            _highlight = [[HighlightView alloc] initWithFrame:[self.view frame] AndPoints:&currentBox];
            [_content addSubview:_highlight];
            //NSLog(@"touch in key: %@ location: %d", [_boxesKey objectAtIndex:location], location);
            AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
            [mainDelegate.viewController.dataController keySignatureWasChosen:[_boxesKey objectAtIndex:location]];
        }
    }
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

-(void)highlightCurrentBox{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextMoveToPoint(context, currentBox.outerCRX, currentBox.outerCRY);
    CGContextAddLineToPoint(context, currentBox.innerCRX, currentBox.innerCRY);
    
    CGContextMoveToPoint(context, currentBox.outerCLX, currentBox.outerCLY);
    CGContextAddLineToPoint(context, currentBox.innerCLX, currentBox.innerCLY);
}

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
        int loc = (i + 1) < 13 ? (i + 1) : 0;
        
        if(t > [_content returnArctanAtLocation: i] && t < [_content returnArctanAtLocation:loc]){
            location = i;
            break;
        }
        if([_content returnArctanAtLocation:loc] < 1 && [_content returnArctanAtLocation:i] > 5.0){
            if (t <= [_content returnArctanAtLocation: loc] || t >= [_content returnArctanAtLocation:i]){
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

