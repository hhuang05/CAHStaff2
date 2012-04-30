//
//  DataController.h
//  Staff
//
//  Created by Aaron Tietz on 3/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Chord.h"
#import "ChordViewController.h"
#import "StaffController.h"

@interface DataController : NSObject{
    int currentNote; 
    int staffMIDIinstrument;
    int chordMIDIinstrument;
    int metronomeMIDIinstrument;
    Chord* currentChord;
}

@property (nonatomic, retain) NSDictionary *keySignatureAccidentals;
@property (nonatomic, retain) NSDictionary *keySignatureNoteMap;
@property (nonatomic, retain) NSDictionary *chordsForKeySignatures;
@property (nonatomic, retain) NSString *currentKeySignature;
@property (nonatomic, retain) NSString *currentKey;
@property (nonatomic, retain) NSArray *majorKeyChords;
@property (nonatomic, retain) NSArray *currentKeySignatureNotes;
@property (nonatomic, retain) NSNumber *chordVolumeAddition;



-(void)keySignatureWasChosen:(NSString*)choice;

// called by StaffController
-(void)playNoteAt:(int)position WithHalfStepAlteration:(int) accidentalState;
-(void)stopNote;
-(void)staffInstrumentWasChosen:(int)MIDInumber;

// called by ChordController
-(void)playChord:(Chord *)chord;
-(void)stopChord:(Chord *)chord;
-(void)metronomeTick;
-(void)stopMetronome;
-(void) chordInstrumentWasChosen:(int)instrument;
-(void)newChordVolumeAdjustment:(float)newValue;

-(BOOL)loadData;
-(void)fillKeySignatureAccidentals;
-(void)fillNotesInKeySignatureDictionary;
-(void)fillChordsDictionary;
-(int)calculateMajorNoteForChord:(Chord*)chord atPosition:(int) pos;

@end
