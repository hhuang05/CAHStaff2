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

@property (nonatomic, strong, readonly) NSDictionary *keySignatureAccidentals;
@property (nonatomic, strong, readonly) NSDictionary *keySignatureNoteMap;
@property (nonatomic, strong, readonly) NSDictionary *chordsForKeySignatures;
@property (nonatomic, strong, readonly) NSDictionary *friendChords;
@property (nonatomic, strong, readonly) NSArray *majorKeyChordFormulas;
@property (nonatomic, strong, readonly) NSArray *minorKeyChordFormulas;

@property (nonatomic, copy) NSString *currentKeySignature;
@property (nonatomic, copy) NSString *currentKey;
@property (nonatomic, copy) NSArray *currentKeySignatureNotes;
@property (nonatomic, copy) NSNumber *chordVolumeAddition;
@property (nonatomic, copy) NSArray *currentChords;



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
-(void)chordInstrumentWasChosen:(int)instrument;
-(void)newChordVolumeAdjustment:(float)newValue;

-(BOOL)loadData;
-(void)fillKeySignatureAccidentals;
-(void)fillNotesInKeySignatureDictionary;
-(int)calculateMajorNoteForChord:(Chord*)chord atPosition:(int) pos;
-(void)setUpFriendChords;
-(NSArray*)setUpChordsToSendWithRootKey:(NSString*)root;

@end
