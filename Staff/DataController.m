//
//  HACStaffDataController.m
//  HACdata
//
//  Created by Aaron Tietz on 3/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "AppDelegate.h"
#import "MainController.h"
#import "StaffController.h"
#import "DataController.h"
#import "Chord.h"

@implementation DataController

@synthesize keySignatureAccidentals = _keySignatureAccidentals, chordsForKeySignatures = _chordsForKeySignatures, currentKeySignature = _currentKeySignature, keySignatureNoteMap = _keySignatureNoteMap, currentKey = _currentKey, currentKeySignatureNotes = _currentKeySignatureNotes, chordVolumeAddition = _chordVolumeAddition, majorKeyChordFormulas = _majorKeyChordFormulas, minorKeyChordFormulas = _minorKeyChordFormulas, currentChords = _currentChords, friendChords = _friendChords;

-(id) init{    
    self = [super init];
    return self;
}

// Set up the maps of key signature note and accidentals, and the 
// chord formula array and initialize the key to C
-(BOOL) loadData{
    [self fillKeySignatureAccidentals];
    [self fillNotesInKeySignatureDictionary];
    [self fillChordsDictionary];
    
    {
		AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
		unsigned char sysex[13] = {0x41, 0x10, 0x42, 0x12, 0x40, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0xF7};
		appDelegate._api->setSystemExclusiveMessage (appDelegate.handle, 0, 0xF0, sysex, 13);
	}
    
    // Initialize key signature choice to C
    [self setCurrentKeySignature:@"C"];
    [self keySignatureWasChosen:_currentKeySignature]; 
    
    // Initialize staff and chord instruments to piano
    [self staffInstrumentWasChosen:0];
    [self chordInstrumentWasChosen:0];

    // set metronome to play the wooden block
    metronomeMIDIinstrument = 115;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC1, metronomeMIDIinstrument, 0x00);

    // set current chord playing to nil and chord volume adjustment to 0
    currentChord = nil;
    _chordVolumeAddition = [[NSNumber alloc] initWithFloat:0.0];
    
    return TRUE;
}


// Create maps of starting notes and locations of accidentals to be 
// sent to the StaffCOntroller for each of the 30 possible key signatures
-(void)fillKeySignatureAccidentals{
    
    NSNumber *flat = [[NSNumber alloc] initWithInt:-1];
    NSNumber *none = [[NSNumber alloc] initWithInt:0];
    NSNumber *sharp = [[NSNumber alloc] initWithInt:1];
    
    NSNumber *B3 = [[NSNumber alloc] initWithInt:15];
    NSNumber *C4 = [[NSNumber alloc] initWithInt:14];
    NSNumber *D4 = [[NSNumber alloc] initWithInt:13];
    NSNumber *E4 = [[NSNumber alloc] initWithInt:12];
    NSNumber *F4 = [[NSNumber alloc] initWithInt:11];
    NSNumber *G4 = [[NSNumber alloc] initWithInt:10];
    NSNumber *A4 = [[NSNumber alloc] initWithInt:9];
    
    // Create arrays for all keySignatures in the Circle of 5ths, where 1 is the first b 
    // above the treble clef and 15 the first b below 0 is a none note
    //  -1 is flat, and 1 is sharp. Position 0 is the starting point of the key
    
    /** all natural notes **/
    
    NSArray *CMajor = [[NSArray alloc] initWithObjects: C4,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    NSArray *AMinor = [[NSArray alloc] initWithObjects:A4,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    
	/** b: B **/
    
    NSArray *FMajor = [[NSArray alloc] initWithObjects:B3,
                       none,none,none,none,
                       none,none,none,flat,
                       none,none,none,none,
                       none,none,none,nil];
    
    NSArray *DMinor = [[NSArray alloc] initWithObjects:D4,
                       none,none,none,none,
                       none,none,none,flat,
                       none,none,none,none,
                       none,none,none,nil];
    
    
    /** b: B, E **/
    
    NSArray *BflatMajor = [[NSArray alloc] initWithObjects: B3,
                           none,none,none,none,
                           flat,none,none,flat,
                           none,none,none,none,
                           none,none,none,nil];
    
    NSArray *GMinor = [[NSArray alloc] initWithObjects:G4,
                       none,none,none,none,
                       flat,none,none,flat,
                       none,none,none,none,
                       none,none,none,nil];
    
    
    /** b: A, B, E **/		
    
    NSArray *EflatMajor = [[NSArray alloc] initWithObjects:E4,
                           none,none,none,none,
                           flat,none,none,flat,
                           flat,none,none,none,
                           none,none,none,nil];
    
    
    NSArray *CMinor = [[NSArray alloc] initWithObjects:C4,
                       none,none,none,none,
                       flat,none,none,flat,
                       flat,none,none,none,
                       none,none,none,nil];
    
    
    /** b: A, B, D, E **/
    
    NSArray *AflatMajor = [[NSArray alloc] initWithObjects:A4,
                           none,none,none,none,
                           flat,flat,none,flat,
                           flat,none,none,none,
                           none,none,none,nil];
    
    NSArray *FMinor = [[NSArray alloc] initWithObjects:F4,
                       none,none,none,none,
                       flat,flat,none,flat,
                       flat,none,none,none,
                       none,none,none,nil];
	
    
    /** b: A, B, D, E, G **/
    
    NSArray *DflatMajor = [[NSArray alloc] initWithObjects:D4,
                           none,none,none,none,
                           flat,flat,none,flat,
                           flat,flat,none,none,
                           none,none,none,nil];

    NSArray *BflatMinor = [[NSArray alloc] initWithObjects:B3,
                           none,none,none,none,
                           flat,flat,none,flat,
                           flat,flat,none,none,
                           none,none,none,nil];

    
    /** b: A, B, C, D, E, G **/
    
    NSArray *GflatMajor = [[NSArray alloc] initWithObjects:G4,
                           none,none,none,none,
                           flat,flat,flat,flat,
                           flat,flat,none,none,
                           none,none,none,nil];

    NSArray *EflatMinor = [[NSArray alloc] initWithObjects:E4,
                           none,none,none,none,
                           flat,flat,flat,flat,
                           flat,flat,none,none,
                           none,none,none,nil];

    
    /** b: A, B, C, D, E, G, F **/

	NSArray *CflatMajor = [[NSArray alloc] initWithObjects:C4,
                           none,none,none,none,
                           flat,flat,flat,flat,
                           flat,flat,flat,none,
                           none,none,none,nil];
    
    NSArray *AflatMinor = [[NSArray alloc] initWithObjects:A4,
                           none,none,none,none,
                           flat,flat,flat,flat,
                           flat,flat,flat,none,
                           none,none,none,nil];

    
    /** #: F **/
    
    NSArray *GMajor = [[NSArray alloc] initWithObjects:G4,
                       none,none,none,sharp,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,nil];

    NSArray *EMinor = [[NSArray alloc] initWithObjects:E4,
                       none,none,none,sharp,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,nil];

    
    /** #: C, F **/
    
    NSArray *DMajor = [[NSArray alloc] initWithObjects:D4,
                       none,none,none,sharp,
                       none,none,sharp,none,
                       none,none,none,none,
                       none,none,none,nil];

    NSArray *BMinor = [[NSArray alloc] initWithObjects:B3,
                       none,none,none,sharp,
                       none,none,sharp,none,
                       none,none,none,none,
                       none,none,none,nil];

    
    /** #: C, F, G **/
    
    NSArray *AMajor = [[NSArray alloc] initWithObjects:A4,
                       none,none,sharp,sharp,
                       none,none,sharp,none,
                       none,none,none,none,
                       none,none,none,nil];

    NSArray *FsharpMinor = [[NSArray alloc] initWithObjects:F4,
                            none,none,sharp,sharp,
                            none,none,sharp,none,
                            none,none,none,none,
                            none,none,none,nil];

    
    /** #: C, D, F, G **/
    
	NSArray *EMajor = [[NSArray alloc] initWithObjects:E4,
                       none,none,sharp,sharp,
                       none,sharp,sharp,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    NSArray *CsharpMinor = [[NSArray alloc] initWithObjects:C4,
                            none,none,sharp,sharp,
                            none,sharp,sharp,none,
                            none,none,none,none,
                            none,none,none,nil];
    
    /** #: A, C, D, F, G **/
    
    NSArray *BMajor = [[NSArray alloc] initWithObjects:B3,
                       none,none,sharp,sharp,
                       none,sharp,sharp,none,
                       sharp,none,none,none,
                       none,none,none,nil];
    
	NSArray *GsharpMinor = [[NSArray alloc] initWithObjects:G4,
                            none,none,sharp,sharp,
                            none,sharp,sharp,none,
                            sharp,none,none,none,
                            none,none,none,nil];
    
    
    /** #: A, C, D, E, F, G **/   
    
    NSArray *FsharpMajor = [[NSArray alloc] initWithObjects:F4,
                            none,none,sharp,sharp,
                            sharp,sharp,sharp,none,
                            sharp,none,none,none,
                            none,none,none,nil];

	NSArray *DsharpMinor = [[NSArray alloc] initWithObjects:D4,
                            none,none,sharp,sharp,
                            sharp,sharp,sharp,none,
                            sharp,none,none,none,
                            none,none,none,nil];	
    
    /** #: A, B, C, D, E, F, G **/   
    
    
	NSArray *CsharpMajor = [[NSArray alloc] initWithObjects:C4,
                            none,none,sharp,sharp,
                            sharp,sharp,sharp,sharp,
                            sharp,none,none,none,
                            none,none,none,nil];	
    
    NSArray *AsharpMinor = [[NSArray alloc] initWithObjects:A4,
                            none,none,sharp,sharp,
                            sharp,sharp,sharp,sharp,
                            sharp,none,none,none,
                            none,none,none,nil];	 
    
    // Fill the keySignatures dictionary with each array and their corresponding key (to be the same as in the circle of fifths picker)
    _keySignatureAccidentals = [[NSDictionary alloc] initWithObjectsAndKeys:
                CMajor, @"C", GMajor, @"G", DMajor, @"D", AMajor, @"A", EMajor, @"E", 
                BMajor, @"B", FsharpMajor, @"F#", DflatMajor, @"Db", CflatMajor, @"Cb", GflatMajor, @"Gb", 
                CsharpMajor, @"C#", AflatMajor, @"Ab", EflatMajor, @"Eb", BflatMajor, @"Bb", FMajor, @"F", 
                AMinor, @"a", EMinor, @"e", BMinor, @"b", FsharpMinor, @"f#", CsharpMinor, @"c#", 
                GsharpMinor, @"g#", DsharpMinor, @"d#", BflatMinor, @"bb", AflatMinor, @"ab", EflatMinor, @"eb",
                AsharpMinor, @"a#", FMinor, @"f", CMinor, @"c", GMinor, @"g", DMinor, @"d", nil];
    
}


// Create a mapping of the notes on the Staff that are used by each
// of the 30 possible key signatures
-(void)fillNotesInKeySignatureDictionary{
    
    NSNumber *fiftyEightNoteNum = [[NSNumber alloc] initWithInt:58];
    NSNumber *fiftyNineNoteNum = [[NSNumber alloc] initWithInt:59];
    NSNumber *sixtyNoteNum = [[NSNumber alloc] initWithInt:60];
    NSNumber *sixtyOneNoteNum = [[NSNumber alloc] initWithInt:61];
    NSNumber *sixtyTwoNoteNum = [[NSNumber alloc] initWithInt:62];
    NSNumber *sixtyThreeNoteNum = [[NSNumber alloc] initWithInt:63];
    NSNumber *sixtyFourNoteNum = [[NSNumber alloc] initWithInt:64];
    NSNumber *sixtyFiveNoteNum = [[NSNumber alloc] initWithInt:65];
    NSNumber *sixtySixNoteNum = [[NSNumber alloc] initWithInt:66];
    NSNumber *sixtySevenNoteNum = [[NSNumber alloc] initWithInt:67];
    NSNumber *sixtyEightNoteNum = [[NSNumber alloc] initWithInt:68];
    NSNumber *sixtyNineNoteNum = [[NSNumber alloc] initWithInt:69];
    NSNumber *seventyNoteNum = [[NSNumber alloc] initWithInt:70];
    NSNumber *seventyOneNoteNum = [[NSNumber alloc] initWithInt:71];
    NSNumber *seventyTwoNoteNum = [[NSNumber alloc] initWithInt:72];
    NSNumber *seventyThreeNoteNum = [[NSNumber alloc] initWithInt:73];
    NSNumber *seventyFourNoteNum = [[NSNumber alloc] initWithInt:74];
    NSNumber *seventyFiveNoteNum = [[NSNumber alloc] initWithInt:75];
    NSNumber *seventySixNoteNum = [[NSNumber alloc] initWithInt:76];
    NSNumber *seventySevenNoteNum = [[NSNumber alloc] initWithInt:77];
    NSNumber *seventyEightNoteNum = [[NSNumber alloc] initWithInt:78];
    NSNumber *seventyNineNoteNum = [[NSNumber alloc] initWithInt:79];
    NSNumber *eightyNoteNum = [[NSNumber alloc] initWithInt:80];
    NSNumber *eightyOneNoteNum = [[NSNumber alloc] initWithInt:81];
    NSNumber *eightyTwoNoteNum = [[NSNumber alloc] initWithInt:82];
    NSNumber *eightyThreeNoteNum = [[NSNumber alloc] initWithInt:83];
    NSNumber *eightyFourNoteNum = [[NSNumber alloc] initWithInt:84];
    
    
    NSArray *CMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *GMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *DMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *AMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, eightyNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtyEightNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *EMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, eightyNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtyEightNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *BMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *FsharpMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySevenNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
 
    NSArray *CsharpMajor = [[NSArray alloc] initWithObjects:eightyFourNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                           seventySevenNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum,
                           sixtySixNoteNum, sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, nil];  
    
    NSArray *CflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySixNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, fiftyEightNoteNum, nil];
   
    NSArray *GflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *DflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *AflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySevenNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *EflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySevenNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *BflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *FMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    
    NSArray* AMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *EMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *BMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *FsharpMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySixNoteNum, seventyFourNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *CsharpMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySixNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *GsharpMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySixNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *DsharpMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySevenNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
	NSArray *AsharpMinor = [[NSArray alloc] initWithObjects:eightyFourNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySevenNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, nil]; 
    
    NSArray *AflatMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySixNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *EflatMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *BflatMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *FMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *CMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventyFiveNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *GMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventyFiveNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *DMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    
    _keySignatureNoteMap = [[NSDictionary alloc] initWithObjectsAndKeys:
     CMajor, @"C", GMajor, @"G", DMajor, @"D", AMajor, @"A", EMajor, @"E", 
     BMajor, @"B", FsharpMajor, @"F#", DflatMajor, @"Db", CflatMajor, @"Cb", GflatMajor, @"Gb", 
     CsharpMajor, @"C#", AflatMajor, @"Ab", EflatMajor, @"Eb", BflatMajor, @"Bb", FMajor, @"F", 
     AMinor, @"a", EMinor, @"e", BMinor, @"b", FsharpMinor, @"f#", CsharpMinor, @"c#", 
     GsharpMinor, @"g#", DsharpMinor, @"d#", BflatMinor, @"bb", AflatMinor, @"ab", EflatMinor, @"eb",
     AsharpMinor, @"a#", FMinor, @"f", CMinor, @"c", GMinor, @"g", DMinor, @"d", nil];

}

// Create a standard formula of Major and minor chord formulas 
-(void) fillChordsDictionary{ 

    NSNumber *one = [[NSNumber alloc]initWithFloat:1.0];
    NSNumber *three = [[NSNumber alloc]initWithFloat:3.0];
    NSNumber *threeFlat = [[NSNumber alloc]initWithFloat:3.1];
    NSNumber *five = [[NSNumber alloc]initWithFloat:5.0];
    NSNumber *fiveFlat = [[NSNumber alloc]initWithFloat:5.1];
    NSNumber *sevenFlat = [[NSNumber alloc]initWithFloat:7.1];
    
    
    Chord *rest = [[Chord alloc] initWithName:@"rest" Notes:nil andID:0];
    
    NSArray *a = [[NSArray alloc] initWithObjects:one, three, five, nil];
    Chord *Maj = [[Chord alloc] initWithName:@"Maj" Notes:a  andID:1];
    
    NSArray *b = [[NSArray alloc] initWithObjects:one, threeFlat, five, nil];
    Chord *min = [[Chord alloc] initWithName:@"min" Notes:b andID:2];

    NSArray *f = [[NSArray alloc] initWithObjects:one, three, five, sevenFlat, nil];
    Chord *dom7 = [[Chord alloc] initWithName:@"dom7" Notes:f andID:6];

    NSArray *h = [[NSArray alloc] initWithObjects:one, threeFlat, fiveFlat, nil];
    Chord *dim = [[Chord alloc] initWithName:@"dim" Notes:h andID:8];
    
    /*
                    Maj: I, ii, iii, IV, V, V7, vi
                    min: i, ii°, III, iv, V, V7, VI
    */
    
    _majorKeyChordFormulas = [[NSArray alloc]initWithObjects:
                        Maj, min, min, Maj, Maj, dom7, min, rest, nil];
    
    _minorKeyChordFormulas = [[NSArray alloc]initWithObjects: 
                        min, dim, Maj, min, Maj, dom7, Maj, rest, nil];
    
    [self setUpFriendChords];

}

-(void)setUpFriendChords{
NSString *restSpace = [[NSString alloc] initWithFormat:@""];
NSString *C  = [[NSString alloc] initWithFormat:@"C"];
NSString *G  = [[NSString alloc] initWithFormat:@"G"];
NSString *D  = [[NSString alloc] initWithFormat:@"D"];
NSString *A  = [[NSString alloc] initWithFormat:@"A"];
NSString *E  = [[NSString alloc] initWithFormat:@"E"];
NSString *B  = [[NSString alloc] initWithFormat:@"B"];
NSString *Fsharp  = [[NSString alloc] initWithFormat:@"F#"];
NSString *Db  = [[NSString alloc] initWithFormat:@"Db"];
NSString *Cb  = [[NSString alloc] initWithFormat:@"Cb"];
NSString *Gb  = [[NSString alloc] initWithFormat:@"Gb"];
NSString *Csharp  = [[NSString alloc] initWithFormat:@"C#"];
NSString *Ab  = [[NSString alloc] initWithFormat:@"Ab"];
NSString *Eb  = [[NSString alloc] initWithFormat:@"Eb"];
NSString *Bb  = [[NSString alloc] initWithFormat:@"Bb"];
NSString *F  = [[NSString alloc] initWithFormat:@"F"];

    /*
NSString *a  = [[NSString alloc] initWithFormat:@"a"];
NSString *e  = [[NSString alloc] initWithFormat:@"e"];
NSString *b  = [[NSString alloc] initWithFormat:@"b"];
NSString *fsharp  = [[NSString alloc] initWithFormat:@"f#"];
NSString *csharp  = [[NSString alloc] initWithFormat:@"c#"];
NSString *eb  = [[NSString alloc] initWithFormat:@"eb"];
NSString *bb  = [[NSString alloc] initWithFormat:@"bb"];
NSString *f  = [[NSString alloc] initWithFormat:@"f"];
NSString *c  = [[NSString alloc] initWithFormat:@"c"];
NSString *g  = [[NSString alloc] initWithFormat:@"g"];
NSString *d  = [[NSString alloc] initWithFormat:@"d"];
NSString *ab  = [[NSString alloc] initWithFormat:@"ab"];
     */
NSString *gsharp  = [[NSString alloc] initWithFormat:@"g#"];
NSString *dsharp  = [[NSString alloc] initWithFormat:@"d#"];
NSString *asharp  = [[NSString alloc] initWithFormat:@"a#"];

NSArray *CMajor = [[NSArray alloc] initWithObjects: 
                   C, D, E, F, G, G, A, restSpace, nil];
NSArray *GMajor = [[NSArray alloc] initWithObjects: 
                   G, A, B, C, D, D, E, restSpace, nil];
NSArray *DMajor = [[NSArray alloc] initWithObjects: 
                   D, E, Fsharp, G, A, A, B, restSpace, nil];
NSArray *AMajor = [[NSArray alloc] initWithObjects: 
                   A, B, Csharp, D, E, E, Fsharp, restSpace, nil]; 
NSArray *EMajor = [[NSArray alloc] initWithObjects: 
                   E, Fsharp, gsharp, A, B, B, Csharp, restSpace, nil];
NSArray *BMajor = [[NSArray alloc] initWithObjects: 
                   B, Csharp, dsharp, E, Fsharp, Fsharp, gsharp, restSpace, nil];
NSArray *FsharpMajor = [[NSArray alloc] initWithObjects: 
                        Fsharp, gsharp, asharp, B, Csharp, Csharp, dsharp, restSpace, nil];
NSArray *DflatMajor = [[NSArray alloc] initWithObjects: 
                       Db, Eb, F, Gb, Ab, Ab, Bb, restSpace, nil];
NSArray *CflatMajor = [[NSArray alloc] initWithObjects: 
                       Cb, Csharp, Eb, E, Gb, Gb, Ab, restSpace, nil]; 
NSArray *GflatMajor = [[NSArray alloc] initWithObjects: 
                       G, Ab, Bb, Cb, Db, Db, Eb, restSpace, nil]; 
NSArray *CsharpMajor = [[NSArray alloc] initWithObjects: 
                        Csharp, dsharp, F, Fsharp, Ab, Ab, asharp, restSpace, nil]; 
NSArray *AflatMajor = [[NSArray alloc] initWithObjects: 
                       Ab, Bb, C, Db, Eb, Eb, F, restSpace, nil];
NSArray *EflatMajor = [[NSArray alloc] initWithObjects: 
                       Eb, F, G, Ab, Bb, Bb, C, restSpace, nil]; 
NSArray *BflatMajor = [[NSArray alloc] initWithObjects: 
                       Bb, C, D, Eb, F, F, G, restSpace, nil];
NSArray *FMajor = [[NSArray alloc] initWithObjects: 
                   F, G, A, Bb, C, C, D, restSpace, nil];
    
    
    NSArray *AMinor = [[NSArray alloc] initWithObjects: 
                       restSpace, nil]; 
    NSArray *EMinor = [[NSArray alloc] initWithObjects: 
                       restSpace, nil]; 
    NSArray *BMinor = [[NSArray alloc] initWithObjects: 
                       restSpace, nil];
    NSArray *FsharpMinor = [[NSArray alloc] initWithObjects: 
                            restSpace, nil];
    NSArray *CsharpMinor = [[NSArray alloc] initWithObjects: 
                            restSpace, nil];
    NSArray *GsharpMinor = [[NSArray alloc] initWithObjects: 
                            restSpace, nil];
    NSArray *DsharpMinor = [[NSArray alloc] initWithObjects: 
                            restSpace, nil]; 
    NSArray *BflatMinor = [[NSArray alloc] initWithObjects: 
                           restSpace, nil]; 
    NSArray *AflatMinor = [[NSArray alloc] initWithObjects: 
                           restSpace, nil]; 
    NSArray *EflatMinor = [[NSArray alloc] initWithObjects: 
                           restSpace, nil];
    NSArray *AsharpMinor = [[NSArray alloc] initWithObjects: 
                            restSpace, nil]; 
    NSArray *FMinor = [[NSArray alloc] initWithObjects: 
                       restSpace, nil]; 
    NSArray *CMinor = [[NSArray alloc] initWithObjects: 
                       restSpace, nil]; 
    NSArray *GMinor = [[NSArray alloc] initWithObjects: 
                       restSpace, nil]; 
    NSArray *DMinor = [[NSArray alloc] initWithObjects: 
                       restSpace, nil];
    
    
    _friendChords = [[NSDictionary alloc] initWithObjectsAndKeys:
        CMajor, @"C", GMajor, @"G", DMajor, @"D", AMajor, @"A", EMajor, @"E", 
        BMajor, @"B", FsharpMajor, @"F#", DflatMajor, @"Db", CflatMajor, @"Cb", GflatMajor, @"Gb", 
        CsharpMajor, @"C#", AflatMajor, @"Ab", EflatMajor, @"Eb", BflatMajor, @"Bb", FMajor, @"F", 
        AMinor, @"a", EMinor, @"e", BMinor, @"b", FsharpMinor, @"f#", CsharpMinor, @"c#", 
        GsharpMinor, @"g#", DsharpMinor, @"d#", BflatMinor, @"bb", AflatMinor, @"ab", EflatMinor, @"eb",
        AsharpMinor, @"a#", FMinor, @"f", CMinor, @"c", GMinor, @"g", DMinor, @"d", nil];
}

// tell each Chord in the array what to concatenate its
// name with, e.g. "F" + "Maj"
-(void)setUpChordsToSendWithRotoKey:(NSString*)root{
    NSArray *friends = [_friendChords objectForKey:root];
    int pos = 0;
    for(Chord *c in _currentChords){
        [c setupKey:[friends objectAtIndex:pos++]];
       // NSLog(@"assigned key: %@", [c key]);
    }
}

// When the user selects a new key signature, tell the 
// Staff where to draw what accidentals, send the chord controller
// the appropriate chords, and set the currentKeySignatureNotes
// for the dataController for playing notes and chords 
-(void)keySignatureWasChosen:(NSString*)choice
{
    // before switching key signatures, stop the current chord
    // so that we don't have lingering notes we can't turn off
    [self stopChord:currentChord];
    
    NSArray* keySignaturetoDraw = [_keySignatureAccidentals objectForKey:choice];   
    _currentKeySignatureNotes = [_keySignatureNoteMap objectForKey:choice];
    _currentKey = choice;
    
    _currentChords = nil;
    if(isupper([choice characterAtIndex:0])){
        _currentChords = [[NSArray alloc] initWithArray:_majorKeyChordFormulas];
    }
    else{
        _currentChords = [[NSArray alloc] initWithArray:_minorKeyChordFormulas];
    }

    [self setUpChordsToSendWithRotoKey:choice];
    
    if(keySignaturetoDraw){
        AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [mainDelegate.viewController.staffController changeScale:keySignaturetoDraw];
        for(Chord* c in _currentChords){
            //NSLog(@"sending: %@", [c key]);
        }
        [mainDelegate.viewController.chordController setUpChords:_currentChords];
    }
    else
        NSLog(@"changeScale called with unknown key signature %@", choice);
}

-(void)newChordVolumeAdjustment:(float)newValue{
    _chordVolumeAddition = [[NSNumber alloc] initWithFloat:newValue];
}

// play a MIDI note with the current chosen instrument, and 
// adjust for half step alteration if the user selected flat
// or sharp option for the grey bar section of the staff
-(void)playNoteAt:(int)position WithHalfStepAlteration:(int) accidentalState{
    
    int noteNumber = [[_currentKeySignatureNotes objectAtIndex:position] intValue];
    // add -1 or 1 to flat or sharp the note if the user wanted
    if(accidentalState){
        noteNumber += accidentalState;
    }
    currentNote = noteNumber;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0x90, noteNumber, 100);
}

// tell MIDI channel 2 to play note 65
-(void)metronomeTick{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0x91, 65, 40);
}

// tell MIDI channel 2 to turn off note 65
-(void)stopMetronome{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0x81, 65, 40);
}

// changes the instrument to be used for the staff player
-(void) staffInstrumentWasChosen:(int)instrument{    
    if(instrument > -1 && instrument < 128){
        staffMIDIinstrument = instrument;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC0, staffMIDIinstrument, 0);
    }
}

-(void) chordInstrumentWasChosen:(int)instrument{

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(instrument > -1 && instrument < 128){
        chordMIDIinstrument = instrument;
        appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC2, chordMIDIinstrument, 0);
        appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC3, chordMIDIinstrument, 0);
        appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC4, chordMIDIinstrument, 0);
        appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC5, chordMIDIinstrument, 0);
        appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC6, chordMIDIinstrument, 0);
        appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC7, chordMIDIinstrument, 0);
    }
}

-(void)stopNote{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0x80, currentNote, 100);
}

-(void)playChord:(Chord *)chord
{
    currentChord = [[Chord alloc] initWithName:[chord name] Notes:[chord notes] andID:1];
    [currentChord setKey:chord.key];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    NSLog(@"Chord key: %@", chord.key);
    
    for (int x=0; x<currentChord.notes.count; x++) {
        int note = [self calculateMajorNoteForChord:currentChord atPosition:x];
        if(note != 0){
            appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 146 + x, note, 42 + [_chordVolumeAddition intValue]);
        }
    }
}

-(int)calculateMajorNoteForChord:(Chord*)chord atPosition:(int) pos{
    int note = 0;
    
    // get the starting note for this key
    int startingLocation = [[[_keySignatureAccidentals objectForKey:currentChord.key] objectAtIndex:0] intValue] - 1;
    //NSLog(@"root note: %d", startingLocation);

    float value = [[chord.notes objectAtIndex:pos] floatValue];
    
    /*
     set precision for all of these values
     */
    
    if (value == 1.0){
        return [[_currentKeySignatureNotes objectAtIndex:startingLocation]intValue];
    }
    else if(value == 3.0){
        return [[_currentKeySignatureNotes objectAtIndex:startingLocation - 2]intValue];
    }
    else if(value > 3.0 && value < 3.15){
        return ([[_currentKeySignatureNotes objectAtIndex:startingLocation - 2]intValue] -1); 
    }
    else if(value == 4.0){
        return [[_currentKeySignatureNotes objectAtIndex:startingLocation - 3]intValue];        
    }    
    else if(value == 5.0){
        return [[_currentKeySignatureNotes objectAtIndex:startingLocation - 4]intValue];
    }
    else if(value == 5.1){
        return ([[_currentKeySignatureNotes objectAtIndex:startingLocation - 4]intValue] -1);        
    }
    else if(value == 5.5){
        return ([[_currentKeySignatureNotes objectAtIndex:startingLocation - 5]intValue] + 1);
    }    
    else if(value == 6.0){
        return [[_currentKeySignatureNotes objectAtIndex:startingLocation - 5]intValue];
    }
    else if(value == 7.1){
        return ([[_currentKeySignatureNotes objectAtIndex:startingLocation - 6]intValue] -1);
    }
    else{
        NSLog(@"unknown chord note float value: %f", value);
    }
    

    return note;
}


-(void)stopChord:(Chord *)chord
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    for (int x=0; x<chord.notes.count; x++) {
        int note = [self calculateMajorNoteForChord:chord atPosition:x];
        if(note != 0){
            appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 130 + x, note, 60);
        }
    }
}

@end
