//
//  ChordOptionsViewController.m
//  Staff
//
//  Created by Hu Huang on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ChordOptionsViewController.h"

@implementation ChordOptionsViewController

@synthesize theChord = _chord;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    _chord.beats = 16;
    _chord.measures = 1;
    _chord.name = @"C";
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 180)];
    
    deleteImage = [UIImage imageNamed:@"DeleteIcon.png"];
    
    beatStepperLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 20)];
    [beatStepperLabel setText: @"Beats per Measure:"];
    [beatStepperLabel setTextAlignment:UITextAlignmentCenter];
    
    beatLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 40, 30, 25)];
    [beatLabel setText:[NSString stringWithFormat:@"%d", _chord.beats]];
    
    beatStepper = [[UIStepper alloc] initWithFrame:CGRectMake(65, 40, 100, 40)];
    [beatStepper addTarget:self action:@selector(stepperPressed:) forControlEvents:UIControlEventValueChanged];
    
    // Set min and max
    [beatStepper setMinimumValue:1];
    [beatStepper setMaximumValue:16];
    
    // Value wraps around from minimum to maximum
    [beatStepper setWraps:YES];
    
    // If continuos (default), changes are sent for each change in stepper,
    // otherwise, change event occurs once user lets up on button
    [beatStepper setContinuous:NO];
    
    deleteChord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteChord.frame = CGRectMake(30, 80, 60, 60);
    [deleteChord setImage:deleteImage forState:UIControlStateNormal];
    [deleteChord addTarget:self action:@selector(delete_onTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:beatStepperLabel];
    [self.view addSubview:beatLabel];
    [self.view addSubview:beatStepper];
    [self.view addSubview:deleteChord];
    
    deletePressed = FALSE;
}

-(void) setPopoverController:(UIPopoverController *) popOverController
{
    // We need a reference to the popover controller so that we can dismiss it
    _popOverController = popOverController;
}

-(void) stepperPressed:(id)sender
{
    
}

-(void) delete_onTouchUpInside
{
    // We will manually call the delegate function
    deletePressed = TRUE;
    [_popOverController dismissPopoverAnimated:TRUE];
    [_popOverController.delegate popoverControllerDidDismissPopover:_popOverController];
}

-(BOOL) wasDeletePressed
{
    return deletePressed;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
