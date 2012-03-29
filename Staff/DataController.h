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
    NSArray *currentKeySignatureNotes;
}

@property (nonatomic, retain) NSDictionary *keySignatureAccidentals;
@property (nonatomic, retain) NSDictionary *keySignatureNoteMap;
@property (nonatomic, retain) NSDictionary *chordsForKeySignatures;
@property (nonatomic, retain) NSString *currentKeySignature;
@property (nonatomic, retain) AVAudioPlayer *notePlayer;
@property (nonatomic, retain) AVAudioPlayer  *chordPlayer;


-(void)keySignatureWasChosen:(NSString*)choice;

// called by StaffController
-(void)playNoteAt:(int)position WithHalfStepAlteration:(BOOL) twoFingerTouch;
-(void)stopNote;

// called by ChordController
-(void)queueChords:(NSDictionary*)progression;
-(void)playChords;
-(void)pauseChords;
-(void)stopChords;

-(BOOL)loadData;
-(void)fillKeySignatureAccidentals;
-(void)fillNotesInKeySignatureDictionary;
-(void)fillChordsDictionary;
-(void)testmethod:(NSString *)className; //to be deleted
@end