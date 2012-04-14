//
//  Circleof5thsController.m
//  Staff
//
//  Created by Christopher Harris on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Circleof5thsController.h"
#import "DataController.h"

@implementation Circleof5thsController

@synthesize circleOf5thsView;
@synthesize circleOf5thsPicker;
@synthesize circleOf5thsPickerElements;
@synthesize circleOf5thsTab;

- (id)init
{
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)setup
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    circleOf5thsPickerElements = [[NSArray alloc] 
                                           initWithObjects:@"F#",@"B",@"E",@"A",@"D",@"G",@"C",@"F",@"Bb",@"Eb",@"Ab",@"Db",@"Gb", nil];
    circleOf5thsView = [[UIView alloc] initWithFrame:CGRectMake(577, 200, 317, 216)];
    [circleOf5thsView setBackgroundColor:[UIColor whiteColor]];
    [[circleOf5thsView layer] setCornerRadius:10];
    [[circleOf5thsView layer] setBorderColor:[UIColor blackColor].CGColor];
    [[circleOf5thsView layer] setBorderWidth:2];
    [[circleOf5thsView layer] setShadowColor:[UIColor blackColor].CGColor];
    [[circleOf5thsView layer] setShadowOpacity:0.7f];
    [[circleOf5thsView layer] setShadowOffset:CGSizeMake(10.0f, 10.0f)];
    [[circleOf5thsView layer] setShadowRadius:10.0f];
    [[circleOf5thsView layer] setMasksToBounds:NO];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:circleOf5thsView.bounds];
    [[circleOf5thsView layer] setShadowPath:path.CGPath];
    
    circleOf5thsTab = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 216)];
    [[circleOf5thsTab layer] setCornerRadius:10];
    [circleOf5thsTab setBackgroundColor:[UIColor lightGrayColor]];
    
    circleOf5thsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(60, 0, 250, 216)];
    [circleOf5thsPicker setDelegate:self];
    [circleOf5thsPicker setDataSource:self];
    [circleOf5thsPicker setShowsSelectionIndicator:YES];
    
    [circleOf5thsView addSubview:circleOf5thsTab];
    [circleOf5thsView addSubview:circleOf5thsPicker];
    
    [mainDelegate.viewController.chordController.view addSubview:circleOf5thsView];
    [circleOf5thsPicker selectRow:6 inComponent:0 animated:YES];
    
    UITapGestureRecognizer *tapCircleOf5thsTab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleOf5thsTabTapped:)];
    [circleOf5thsTab addGestureRecognizer:tapCircleOf5thsTab];
}

- (void)circleOf5thsTabTapped:(UITapGestureRecognizer *)recognizer;
{
    NSLog(@"here");
    NSLog(@"%f",circleOf5thsView.layer.position.x);
    
    double x = circleOf5thsView.layer.position.x;
    double y = circleOf5thsView.layer.position.y;
    if(x < 500){
        [[circleOf5thsView layer] setPosition:CGPointMake(742, y)];
    } else {
        [[circleOf5thsView layer] setPosition:CGPointMake(472, y)];
    }
    
}

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [circleOf5thsPickerElements count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [circleOf5thsPickerElements objectAtIndex: row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [mainDelegate.viewController.dataController keySignatureWasChosen:[circleOf5thsPickerElements objectAtIndex: row]];
   
    //NSLog(@"You selected this: %@", [circleOf5thsPickerElements objectAtIndex: row]);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
