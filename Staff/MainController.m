//
//  MainController.m
//  Staff
//
//  Created by Aaron Tietz on 3/27/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "DataController.h"
#import "StaffController.h"
#import "ChordViewController.h"

@implementation MainController

@synthesize staffController = _staffController, dataController = _dataController, chordController = _chordController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataController = [[DataController alloc] init];
    _staffController = [[StaffController alloc] init];
    _chordController = [[ChordViewController alloc] init];
    [_chordController loadView];
    [_dataController loadData];
    
    
    [self addChildViewController:self.staffController];
    [self addChildViewController:self.chordController];
    
    [self.view addSubview: self.chordController.view];
    [self.view addSubview: self.staffController.view];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
