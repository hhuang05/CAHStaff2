//
//  TwoFingerOptionSelector.m
//  Staff
//
//  Created by Aaron Tietz on 4/14/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "TwoFingerOptionSelector.h"
#import "DataController.h"
#import "AppDelegate.h"

@implementation TwoFingerOptionSelector

@synthesize TwoFingerOptionsTab = _TwoFingerOptionsTab, TwoFingerOptionPicker = _TwoFingerOptionsPicker, TwoFingerOptionsElements = _TwoFingerOptionsElements, TwoFingerOptionSelectorView = _TwoFingerOptionsSelectorView;

- (id)init{
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)setup
{
    _TwoFingerOptionsElements = [[NSArray alloc] 
                                  initWithObjects:@"Apply sharp",@"No effect",@"Apply flat", nil];
    _TwoFingerOptionsSelectorView = [[UIView alloc] initWithFrame:CGRectMake(577, 450, 260, 250)];
    [_TwoFingerOptionsSelectorView setBackgroundColor:[UIColor whiteColor]];
    [[_TwoFingerOptionsSelectorView layer] setCornerRadius:10];
    [[_TwoFingerOptionsSelectorView layer] setBorderColor:[UIColor blackColor].CGColor];
    [[_TwoFingerOptionsSelectorView layer] setBorderWidth:2];
    [[_TwoFingerOptionsSelectorView layer] setShadowColor:[UIColor blackColor].CGColor];
    [[_TwoFingerOptionsSelectorView layer] setShadowOpacity:0.7f];
    [[_TwoFingerOptionsSelectorView layer] setShadowOffset:CGSizeMake(10.0f, 10.0f)];
    [[_TwoFingerOptionsSelectorView layer] setShadowRadius:10.0f];
    [[_TwoFingerOptionsSelectorView layer] setMasksToBounds:NO];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:_TwoFingerOptionsSelectorView.bounds];
    [[_TwoFingerOptionsSelectorView layer] setShadowPath:path.CGPath];

    _TwoFingerOptionsTab = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 250)];
    [[_TwoFingerOptionsTab layer] setCornerRadius:10];
    [_TwoFingerOptionsTab setBackgroundColor:[UIColor lightGrayColor]];
    
    _TwoFingerOptionsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(60, 10, 210, 220)];
    [_TwoFingerOptionsPicker setDelegate:self];
    [_TwoFingerOptionsPicker setDataSource:self];
    [_TwoFingerOptionsPicker setShowsSelectionIndicator:YES];
    
    [_TwoFingerOptionsSelectorView addSubview:_TwoFingerOptionsTab];
    [_TwoFingerOptionsSelectorView addSubview:_TwoFingerOptionsPicker];
    
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [mainDelegate.viewController.chordController.view addSubview:_TwoFingerOptionsSelectorView];
    [_TwoFingerOptionsPicker selectRow:3 inComponent:0 animated:YES];
    
    UITapGestureRecognizer *tapTwoFingerOptionsTab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerOptionSelected:)];
    [_TwoFingerOptionsTab addGestureRecognizer:tapTwoFingerOptionsTab];
}

- (void)twoFingerOptionSelected:(UITapGestureRecognizer *)recognizer;
{
    NSLog(@"here");
    NSLog(@"%f",_TwoFingerOptionsSelectorView.layer.position.x);
    
    double x = _TwoFingerOptionsSelectorView.layer.position.x;
    double y = _TwoFingerOptionsSelectorView.layer.position.y;
    if(x < 700){
        [[_TwoFingerOptionsSelectorView layer] setPosition:CGPointMake(710, y)];
    } else {
        [[_TwoFingerOptionsSelectorView layer] setPosition:CGPointMake(520, y)];
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
    return [_TwoFingerOptionsElements count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_TwoFingerOptionsElements objectAtIndex: row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [mainDelegate.viewController.dataController twoFingerOptionWasSelected:[_TwoFingerOptionsElements objectAtIndex: row]];
    
    //NSLog(@"You selected this: %@", [circleOf5thsPickerElements objectAtIndex: row]);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
