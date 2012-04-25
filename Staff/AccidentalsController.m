//
//  AccidentalsController.m
//  Staff
//
//  Created by Christopher Harris on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AccidentalsController.h"

@implementation AccidentalsController

@synthesize picker;
@synthesize state;

- (id)init
{
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    elements = [[NSArray alloc] initWithObjects:@"No Effect", @"Apply Sharp", @"Apply Flat", nil];
    content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    [picker setDataSource:self];
    [picker setDelegate:self];
    [picker setShowsSelectionIndicator:YES];
    [content addSubview:picker];
    [self.view addSubview:content];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [elements count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [elements objectAtIndex:row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
<<<<<<< HEAD
=======
    //[mainDelegate.viewController.dataController twoFingerOptionWasSelected:[elements objectAtIndex: row]];
>>>>>>> d779a4d4beda77488e1d9c12ef013e2b28786366
    [mainDelegate.viewController.staffController.sharpFlatButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [mainDelegate.viewController.staffController.sharpFlatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    switch (row) {
        case 0:
            [mainDelegate.viewController.staffController.sharpFlatButton setTitle:@"-" forState:UIControlStateNormal];
            [self setState:0];
            break;
        case 1:
            [mainDelegate.viewController.staffController.sharpFlatButton setTitle:@"#" forState:UIControlStateNormal];
            [self setState:-1];
            break;
        case 2:
            [mainDelegate.viewController.staffController.sharpFlatButton setTitle:@"b" forState:UIControlStateNormal];
            [self setState:1];
            break;
        default:
            break;
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
