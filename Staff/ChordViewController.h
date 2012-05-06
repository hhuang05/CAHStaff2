//
//  ChordViewController.h
//  COMP150ISWFinalProject
//
//  Created by Hu Huang on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggedChord.h"
#import "ChordInstrumentsController.h"
#import "CircleOfFifthsViewController.h"
#import "solidVerticalLine.h"

@interface ChordViewController : UIViewController <UITextFieldDelegate, UIPopoverControllerDelegate>
{
    NSString *currentKey; 
    UIImage *starImage;
    
    // 8 Buttons for chord pickers
    DraggedChord *picker1;
    DraggedChord *picker2;
    DraggedChord *picker3;
    DraggedChord *picker4;
    DraggedChord *picker5;
    DraggedChord *picker6;
    DraggedChord *picker7;
    DraggedChord *picker8;
    
    // Images for the pickers
    UIImage *_orangeNote;
    UIImage *_blueNote;
    UIImage *_greenNote;
    UIImage *_yellowNote;
    UIImage *_redNote;
    UIImage *_tealNote;
    UIImage *_navyNote;
    UIImage *_purpleNote;
    
    // 8 Buttons for the chords chosen
    UIButton *chordChosen1;
    UIButton *chordChosen2;
    UIButton *chordChosen3;
    UIButton *chordChosen4;
    UIButton *chordChosen5;
    UIButton *chordChosen6;
    UIButton *chordChosen7;
    UIButton *chordChosen8;

    
    // 4 Buttons, Play, Stop, Clear All and Switch keys
    UIButton *play;
    UIButton *stop;
    UIButton *clearAll;
    
    // 4 Icons to show when the chord player starts playing
    UIImageView *star1;
    UIImageView *star2;
    UIImageView *star3;
    UIImageView *star4;
    
    DraggedChord *draggedChord; // The chord that is selected and is dragged
    
    BOOL isPaused;
    BOOL starsHaveAppeared;
    
    UIPopoverController *popOverController;
    
    NSMutableArray *chordChoices; //The chords that can be chosen for a specific key
    NSArray *pickerArray;
    NSArray *chosenChordButtonsArray;
    NSMutableArray *chordsToBePlayed; // These are the chords that are chosen that are to be played
    NSMutableArray *chordsToBePlayedIndexes; //These are the indexes of the chords chosen within the chosen array
    NSMutableArray *progressionToBeSent;
    
    // Metronome properties
    IBOutlet UIStepper *bpmStepper;
    IBOutlet UILabel *bpmLabel;
    IBOutlet UISwitch *metronomeOnOff;
    NSTimer *metronomeTimer;
    
    int beforePlayCounter;
    int currentChordPlayingIndex;
    Chord *currentChordPlaying;
    Chord *previousChord;
    NSTimer *chordTimer;
    int progressionEndIndx;
}

//Metronome properties
@property (nonatomic, retain) UIStepper *bpmStepper;
@property (nonatomic, retain) UILabel *bpmLabel;
@property (nonatomic, retain) UISwitch *metronomeOnOff;
@property(nonatomic, retain) NSTimer *metronomeTimer;

// top menu with instrument and circle of 5ths pickers
// button to show current instrument
@property (nonatomic, retain) UIView *topMenu;

@property (nonatomic, retain) UIButton *instrumentsButton;
@property (nonatomic, retain) UIPopoverController *instumentPopoverController;
@property (nonatomic, retain) ChordInstrumentsController *instrumentsController;

@property (nonatomic, retain) UIButton *circleOfFifthsButton;
@property (nonatomic, retain) UIPopoverController *circleOfFifthsPopoverController;
@property (nonatomic, retain) CircleOfFifthsViewController *circleOfFirthsViewController;


@property (nonatomic, retain) IBOutlet UISlider *chordVolume;

-(NSString *) currentKey;
-(void) currentKey: (NSString *) newKey;
-(void) setUpChords:(NSArray*)theChords;
-(void) setupMetronome;
-(void) fireChord;
-(void) setUpVolumeSlider;

-(void) scaleUpChordChosenButton:(UIButton *)theButton;
-(void) scaleDownChordChosenButton:(UIButton *)theButton;
-(void) buildTopMenu;
// Chord Pickers are the buttons at the bottom which the user can use to select the chords to be played
-(void) layoutChordPickers;

// Chords to be played are the buttons at the top that are to be played in the chord progression
-(void) layoutChordsToBePlayed;

// Control bar are the buttons in the middle
-(void) layoutControlBar;
-(void) layoutStars;

// Drag and drop handlers
-(void) dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position;
-(void) dispatchTouchEvent:(UIView *)theView toPosition:(CGPoint)position;
-(void) dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event;
-(void) animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIView *)theView;
-(void) animateView:(UIView *)theView toPosition:(CGPoint)thePosition;

-(void) clearButton_onTouchUpInside;
-(void) playButton_onTouchUpInside;
-(void) stopButton_onTouchUpInside;
-(void) chordChosen_onTouchUpInside:(id)sender;
-(UIView *) deepCopySolidVerticalLine:(solidVerticalLine *)theView;

- (IBAction)openCircleOfFifthsMenu:(id)sender;

@end
