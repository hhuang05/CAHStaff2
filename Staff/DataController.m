//
//  HACStaffDataController.m
//  HACdata
//
//  Created by Aaron Tietz on 3/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "StaffController.h"
#import "DataController.h"

@implementation DataController

@synthesize keySignatureAccidentals = _keySignatureAccidentals, chordsForKeySignatures = _chordsForKeySignatures, currentKeySignature = _currentKeySignature, notePlayer = _notePlayer, chordPlayer = _chordPlayer, keySignatureNoteMap = _keySignatureNoteMap;

-(id) init{    
    self = [super init];
    return self;
}

-(BOOL) loadData{
    [self fillKeySignatureAccidentals];
    [self fillNotesInKeySignatureDictionary];
    [self fillChordsDictionary];
    
    // Initialize key signature choice to F
    [self setCurrentKeySignature:@"F"];
    [self keySignatureWasChosen:_currentKeySignature]; 
    
    _notePlayer = [[AVAudioPlayer alloc] init];
    _chordPlayer = [[AVAudioPlayer alloc] init];
    halfStepAlteration = 0;
    
    return TRUE;
}

-(void)testmethod:(NSString *)className //to be deleted
{
    NSLog(@"I got called from the %@",className);
}

-(void)fillKeySignatureAccidentals{
    
    // Create arrays for all keySignatures in the Circle of 5ths, where 0 is the first b above the treble clef 
    // and 14 the first b below 0 is a natural note, -1 is flat, and 1 is sharp
    NSArray *CMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *GMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *DMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"1",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *AMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"1",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *EMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"1",@"0",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *BMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"1",@"0",@"1",@"1",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *GflatMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *FsharpMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"1",@"1",@"1",@"1",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *DflatMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"-1",@"0",@"-1",@"-1",@"-1",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *AflatMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"-1",@"0",@"-1",@"-1",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *EflatMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"0",@"0",@"-1",@"-1",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *BflatMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"0",@"0",@"-1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *FMajor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"-1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *AMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *EMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    NSArray *BMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"1",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *FsharpMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"1",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *CsharpMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"1",@"0",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *GsharpMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"1",@"0",@"1",@"1",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *EflatMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *DsharpMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"1",@"1",@"1",@"1",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *BflatMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"-1",@"0",@"-1",@"-1",@"-1",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *FMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"-1",@"0",@"-1",@"-1",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *CMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"0",@"0",@"-1",@"-1",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *GMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"0",@"0",@"-1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray *DMinor = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"-1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    
    
    // Fill the keySignatures dictionary with each array and their corresponding key (to be the same as in the circle of fifths picker)
    _keySignatureAccidentals = [[NSDictionary alloc] initWithObjectsAndKeys:
        CMajor, @"C", GMajor, @"G", DMajor, @"D", AMajor, @"A", EMajor, @"E", BMajor, @"B", GflatMajor, @"Gb", FsharpMajor, @"F#", DflatMajor, @"Db", AflatMajor, @"Ab", EflatMajor, @"Eb", BflatMajor, @"Bb", FMajor, @"F", AMinor, @"A Minor", EMinor, @"E Minor", BMinor, @"B Minor", FsharpMinor, @"F# Minor", CsharpMinor, @"C# Minor", GsharpMinor, @"G# minor", EflatMinor, @"Eb Minor", DsharpMinor, @"D# Minor", BflatMinor, @"Bb Minor", FMinor, @"F Minor", CMinor, @"C Minor", GMinor, @"G Minor", DMinor, @"D Minor", nil];
    
    /*
     NSLog(@"Number of arrays in key signature accidentals: %d", [_keySignatureAccidentals count]);
     NSEnumerator *enumerator = [_keySignatureAccidentals objectEnumerator];
     id object;
     
     while ((object = [enumerator nextObject])) {
         NSLog(@"%d", [object count]);
     }
     */
    
}

-(void)fillNotesInKeySignatureDictionary{
    
    NSArray *CMajor = [[NSArray alloc] initWithObjects:@"83", @"81", @"79", @"77", @"76", @"74", @"72", @"71", @"69", @"67", @"65", @"64", @"62", @"60", @"59", nil];
    
    NSArray *GMajor = [[NSArray alloc] initWithObjects:@"83", @"81", @"79", @"78", @"76", @"74", @"72", @"71", @"69", @"67", @"66", @"64", @"62", @"60", @"59", nil];
  
    NSArray *DMajor = [[NSArray alloc] initWithObjects:@"83", @"81", @"79", @"78", @"76", @"74", @"73", @"71", @"69", @"67", @"66", @"64", @"62", @"61", @"59", nil];
    
    NSArray *AMajor = [[NSArray alloc] initWithObjects:@"83", @"81", @"80", @"78", @"76", @"74", @"73", @"71", @"69", @"68", @"66", @"64", @"62", @"61", @"59", nil];
    
    NSArray *EMajor = [[NSArray alloc] initWithObjects:@"83", @"81", @"80", @"78", @"76", @"75", @"73", @"71", @"69", @"68", @"66", @"64", @"63", @"61", @"59", nil];
    
    NSArray *BMajor = [[NSArray alloc] initWithObjects:@"83", @"82", @"80", @"78", @"76", @"75", @"73", @"71", @"70", @"68", @"66", @"64", @"63", @"61", @"59", nil];
    
    NSArray *FsharpMajor = [[NSArray alloc] initWithObjects:@"83", @"82", @"80", @"78", @"77", @"75", @"73", @"71", @"70", @"68", @"66", @"65", @"63", @"61", @"59", nil];
    
    NSArray *FMajor = [[NSArray alloc] initWithObjects:@"82", @"81", @"79", @"77", @"76", @"74", @"72", @"70", @"69", @"67", @"65", @"64", @"62", @"60", @"58", nil];
    
    NSArray *BflatMajor = [[NSArray alloc] initWithObjects:@"82", @"81", @"79", @"77", @"75", @"74", @"72", @"70", @"69", @"67", @"65", @"63", @"62", @"60", @"58", nil];
    
    NSArray *EflatMajor = [[NSArray alloc] initWithObjects:@"82", @"80", @"79", @"77", @"75", @"74", @"72", @"70", @"68", @"67", @"65", @"63", @"62", @"60", @"58", nil];
    
    NSArray *AflatMajor = [[NSArray alloc] initWithObjects:@"82", @"80", @"79", @"77", @"75", @"73", @"72", @"70", @"68", @"67", @"65", @"63", @"61", @"60", @"58", nil];
    
    NSArray *DflatMajor = [[NSArray alloc] initWithObjects:@"82", @"80", @"78", @"77", @"75", @"73", @"72", @"70", @"68", @"66", @"65", @"63", @"61", @"60", @"58", nil];
    
    NSArray *GflatMajor = [[NSArray alloc] initWithObjects: @"82", @"80", @"78", @"77", @"75", @"73", @"71", @"70", @"68", @"66", @"65", @"63", @"61", @"69", @"58", nil];
    
    NSArray* AMinor = [[NSArray alloc] initWithObjects:@"83", @"81", @"79", @"77", @"76", @"74", @"72", @"71", @"69", @"67", @"65", @"64", @"62", @"60", @"59", nil];
    
    NSArray *EMinor = [[NSArray alloc] initWithObjects: @"83", @"81", @"79", @"78", @"76", @"74", @"72", @"71", @"69", @"67", @"66", @"64", @"62", @"60", @"59", nil];
    
    NSArray *BMinor = [[NSArray alloc] initWithObjects: @"83", @"81", @"79", @"78", @"76", @"74", @"73", @"71", @"69", @"67", @"66", @"64", @"62", @"61", @"59", nil];
    
    NSArray *FsharpMinor = [[NSArray alloc] initWithObjects:@"83", @"81", @"80", @"78", @"76", @"74", @"73", @"71", @"69", @"68", @"66", @"64", @"62", @"61", @"59", nil];
    
    NSArray *CsharpMinor = [[NSArray alloc] initWithObjects:@"83", @"81", @"80", @"78", @"76", @"75", @"73", @"71", @"69", @"68", @"66", @"64", @"63", @"61", @"59", nil];
    
    NSArray *GsharpMinor = [[NSArray alloc] initWithObjects:@"83", @"82", @"80", @"78", @"76", @"75", @"73", @"71", @"70", @"68", @"66", @"64", @"63", @"61", @"59", nil];
    
    NSArray *DsharpMinor = [[NSArray alloc] initWithObjects:@"83", @"82", @"80", @"78", @"77", @"75", @"73", @"71", @"70", @"68", @"66", @"65", @"63", @"61", @"59", nil];
    
    NSArray *EflatMinor = [[NSArray alloc] initWithObjects:@"83", @"80", @"78", @"77", @"75", @"73", @"71", @"70", @"68", @"66", @"65", @"63", @"61", @"59", @"58", nil];
    
    NSArray *BflatMinor = [[NSArray alloc] initWithObjects:@"83", @"80", @"78", @"77", @"75", @"73", @"72", @"70", @"68", @"66", @"65", @"63", @"61", @"60", @"58", nil];
    
    NSArray *FMinor = [[NSArray alloc] initWithObjects:@"83", @"80", @"79", @"77", @"75", @"73", @"72", @"70", @"68", @"67", @"65", @"63", @"61", @"60", @"58", nil];
    
    NSArray *CMinor = [[NSArray alloc] initWithObjects:@"83", @"80", @"79", @"77", @"75", @"74", @"72", @"70", @"68", @"67", @"65", @"63", @"62", @"60", @"58", nil];
    
    NSArray *GMinor = [[NSArray alloc] initWithObjects:@"83", @"81", @"79", @"77", @"75", @"74", @"72", @"70", @"69", @"67", @"65", @"63", @"62", @"60", @"58", nil];
    
    NSArray *DMinor = [[NSArray alloc] initWithObjects:@"83", @"81", @"79", @"77", @"76", @"74", @"72", @"70", @"69", @"67", @"65", @"64", @"62", @"60", @"58", nil];
    
    _keySignatureNoteMap = [[NSDictionary alloc] initWithObjectsAndKeys:
            CMajor, @"C", GMajor, @"G", DMajor, @"D", AMajor, @"A", EMajor, @"E", BMajor, @"B", GflatMajor, @"Gb", FsharpMajor, @"F#", DflatMajor, @"Db", AflatMajor, @"Ab", EflatMajor, @"Eb", BflatMajor, @"Bb", FMajor, @"F", AMinor, @"A Minor", EMinor, @"E Minor", BMinor, @"B Minor", FsharpMinor, @"F# Minor", CsharpMinor, @"C# Minor", GsharpMinor, @"G# minor", EflatMinor, @"Eb Minor", DsharpMinor, @"D# Minor", BflatMinor, @"Bb Minor", FMinor, @"F Minor", CMinor, @"C Minor", GMinor, @"G Minor", DMinor, @"D Minor", nil];
    
    
    /*
    NSLog(@"Number of arrays in key signature not map: %d", [_keySignatureNoteMap count]);
    NSEnumerator *enumerator = [_keySignatureNoteMap objectEnumerator];
    id object;
    
    while ((object = [enumerator nextObject])) {
        NSLog(@"%d", [object count]);
    }
    */
}


-(void) fillChordsDictionary{    
    
    NSArray *FMzero = [[NSArray alloc] initWithObjects:@"65", @"69", @"72", nil];
    Chord* zero = [[Chord alloc] initWithName:@"F Major" Notes:FMzero  andID:0];
    NSArray *FMone = [[NSArray alloc] initWithObjects:@"65", @"68", @"72", nil];
    Chord* one = [[Chord alloc] initWithName:@"F Minor" Notes:FMone andID:1];
    NSArray *FMtwo = [[NSArray alloc] initWithObjects:@"65", @"69", @"73", nil];
    Chord* two = [[Chord alloc] initWithName:@"F Augmented" Notes:FMtwo andID:2];
    NSArray *FMthree = [[NSArray alloc] initWithObjects:@"65", @"68", @"71", nil];
    Chord* three = [[Chord alloc] initWithName:@"F diminshed" Notes:FMthree andID:3];
    NSArray *FMfour = [[NSArray alloc] initWithObjects:@"65", @"70", @"72", nil];
    Chord* four = [[Chord alloc] initWithName:@"F suspended 4" Notes:FMfour andID:4];
    NSArray *FMfive = [[NSArray alloc] initWithObjects:@"65", @"69", @"72", @"74", nil];
    Chord* five = [[Chord alloc] initWithName:@"F Major 6" Notes:FMfive andID:5];
    NSArray *FMsix = [[NSArray alloc] initWithObjects:@"65", @"68", @"72", @"74", nil];
    Chord* six = [[Chord alloc] initWithName:@"F Minor 6" Notes:FMsix andID:6];
    NSArray *FMseven = [[NSArray alloc] initWithObjects:@"65", @"69", @"72", @"75", nil];
    Chord* seven = [[Chord alloc] initWithName:@"F Dominant 7" Notes:FMseven andID:7];
    
    NSArray *FMajor = [[NSArray alloc]initWithObjects:zero, one, two, three, four, five, six, seven , nil];
    
    //
    // SO FAR JUST F MAJOR HAS BEEN ADDED 
    //
    _chordsForKeySignatures = [[NSDictionary alloc] initWithObjectsAndKeys: FMajor, @"F", nil];
}


-(void)keySignatureWasChosen:(NSString*)choice
{
    
    NSArray* keySignaturetoDraw = [_keySignatureAccidentals objectForKey:choice];
    NSArray* chordsForKey = [_chordsForKeySignatures objectForKey:choice];
    currentKeySignatureNotes = [_keySignatureNoteMap objectForKey:choice];

    
    if(keySignaturetoDraw){
        AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [mainDelegate.viewController.staffController changeScale:keySignaturetoDraw];
        [mainDelegate.viewController.chordController setUpChords:(NSArray*)chordsForKey];
    }
    else
        NSLog(@"changeScale called with unknown key signature %@", choice);
}


-(void)playNoteAt:(int)position WithHalfStepAlteration:(BOOL) twoFingerTouch{
    
    int noteNumber = [[currentKeySignatureNotes objectAtIndex:position] intValue];
    
    // add -1 or 1 to flat or sharp the note if the user wanted
    if(twoFingerTouch){
        noteNumber += halfStepAlteration;
    }
    
    NSLog(@"Playing note %d", noteNumber);
    
    // begin playing given note
}

-(void)stopNote{
    NSLog(@"Stopped playing note");
    //[_notePlayer stop];
}


-(void)queueChords:(NSArray*)progression{
    // prep chord progression for playing
}


-(void)playChords{
    NSLog(@"received message to play chords");
    //[_chordPlayer play];
}


-(void)pauseChords{
    NSLog(@"received message to pause chords");
    //[_chordPlayer pause];
}


-(void)stopChords{
    NSLog(@"received message to stop chords");
    //[_chordPlayer stop];
}

@end
