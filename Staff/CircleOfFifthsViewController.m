//
//  CircleOfFifthsViewController.m
//  Staff
//
//  Created by Aaron Tietz on 4/30/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//
#import "CircleOfFifthsViewController.h"

@implementation CircleOfFifthsViewController

@synthesize content = _content;

-(id)init{
    self = [super init];
    if (self){
        _content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
        [_content setBackgroundColor:[UIColor whiteColor]];
        [_content addSubview:[self deepCopyCircleView:_content]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIView *)deepCopyCircleView:(UIView *)theView
{
    CircleView *newView = [[CircleView alloc] initWithFrame:[theView frame]];
    [newView setBackgroundColor:[UIColor lightGrayColor]];
    [newView setAlpha:0.5f];
    return newView;
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *allTouches = [touches allObjects];
    for(UITouch* t in allTouches){
        NSLog(@" Circle of 5th touch at %@", [t description]);
    }
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
