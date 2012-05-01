//
<<<<<<< HEAD
//  InstrumentsController.m
//  Staff
//
//  Created by Christopher Harris on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "InstrumentsController.h"
=======
//  ChordInstrumentsController.m
//  Staff
//
//  Created by Aaron Tietz on 5/1/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "AppDelegate.h"
#import "ChordInstrumentsController.h"
>>>>>>> temp

@implementation ChordInstrumentsController

@synthesize picker;
@synthesize instrument;

- (id)init
{
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupInstrumentsElements];
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

- (void)setupInstrumentsElements
{
    elements = [[NSArray alloc] initWithObjects:
                @"Acoustic Piano",@"Bright Acoustic Piano",@"Electric Grand Piano",@"Honky-Tonk Piano",@"Electric Piano 1",@"Electric Piano 2",@"Harpsichord",@"Clavinet",
                @"Celesta",@"Glockenspiel",@"Music Box",@"Vibraphone",@"Marimba",@"Xylophone",@"Tubular Bells",@"Dulcimer",
                @"Drawbar Organ",@"Percussive Organ",@"Rock Organ",@"Church Organ",@"Reed Organ",@"Accordian",@"Harmonica",@"Tango Accordian",
                @"Acoustic Guitar (Nylon)",@"Acoustic Guitar (Steel)",@"Electric Guitar (Jazz)",@"Electric Guitar (Clean)",@"Electric Guitar (Muted)",@"Overdriven Guitar",@"Distortion Guitar",@"Guitar Harmonics",
                @"Acoustic Bass",@"Electric Bass (Finger)",@"Electric Bass (Pick)",@"Freless Bass",@"Slap Bass 1",@"Slap Bass 2",@"Synth Bass 1",@"Synth Bass 2",
                @"Violin",@"Viola",@"Cello",@"Contrabass",@"Tremelo Strings",@"Pizzicato Strings",@"Orchestral Harp",@"Timpani",
                @"String Ensemble 1",@"String Ensemble 2",@"Synth Strings 1",@"Synth Strings 2",@"Choir Aahs",@"Voice Oohs",@"Synth Voice",
                @"Orchestra Hit", @"Trumpet",@"Trombone",@"Tuba",@"Muted Trumpet",@"French Horn",@"Brass Section",@"Synth Brass 1",
                @"Synth Brass 2",@"Soprano Sax",@"Alto Sax",@"Tenor Sax",@"Baritone Sax",@"Oboe",@"English Horn",@"Bassoon",@"Clarinet",
                @"Piccolo",@"Flute",@"Recorder",@"Pan Flute",@"Blown Bottle",@"Shakuhachi",@"Whistle",@"Ocarina",nil];
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
    [mainDelegate.viewController.chordController.instrumentsButton setTitle:[elements objectAtIndex:row] forState:UIControlStateNormal];
    instrument = row;
=======
    instrument = row;
    [mainDelegate.viewController.chordController.instrumentsButton setTitle:[elements objectAtIndex:row] forState:UIControlStateNormal];
    
>>>>>>> temp
    [mainDelegate.viewController.dataController chordInstrumentWasChosen:instrument];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
