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
    int halfStepAlteration;
    int currentNote;
    NSInteger MIDIinstrument;
    NSArray *currentKeySignatureNotes;
}

@property (nonatomic, retain) NSDictionary *keySignatureAccidentals;
@property (nonatomic, retain) NSDictionary *keySignatureNoteMap;
@property (nonatomic, retain) NSDictionary *chordsForKeySignatures;
@property (nonatomic, retain) NSString *currentKeySignature;


-(void)keySignatureWasChosen:(NSString*)choice;

// called by StaffController
-(void)playNoteAt:(int)position WithHalfStepAlteration:(BOOL) twoFingerTouch;
-(void)stopNote;
-(void)instrumentWasChosen:(int)MIDInumber;

// called by ChordController
-(void)playChords:(NSArray*)progression;
-(void)pauseChords;
-(void)stopChords;
-(void)metronomeTick;
-(void)twoFingerOptionWasSelected:(NSString*)option;

-(BOOL)loadData;
-(void)fillKeySignatureAccidentals;
-(void)fillNotesInKeySignatureDictionary;
-(void)fillChordsDictionary;
@end
