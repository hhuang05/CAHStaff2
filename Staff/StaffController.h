//
//  StaffController.h
//  Staff
//
//  Created by Christopher Harris on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "solidLine.h"
#import "dashedLine.h"
#import "solidlineAccidental.h"
#import "dashedlineAccidental.h"
#import "sharpIcon.h"
#import "InstrumentsController.h"
#import "AccidentalsController.h"


#define NUMBER_OF_NOTES 15
#define ICON_COUNT 7
#define MAXTOUCHES 4

typedef struct image_view_metadata {
    int height;
    int width;
    int x;
    int y;
} IVM; 

@interface StaffController : UIViewController {
    UIView *canvas;
    UIView *staffView;
    UIView *topMenu;
    UIButton *instrumentsButton;
    UIButton *sharpFlatButton;
    UIPopoverController *popoverController;
    UIView *popoverView;
    InstrumentsController *instrumentsController;
    AccidentalsController *accidentalsController;
    NSMutableDictionary *lines;
    NSMutableDictionary *spaces;
    NSMutableDictionary *sharps;
    NSMutableDictionary *flats;
    NSMutableDictionary *dots;
    NSArray *notes;
    UIImage *wrinkledPaper;
    int currentDotLocation;
    int numtouches;
}

@property (nonatomic, retain) IBOutlet UIView *canvas;
@property (nonatomic, retain) IBOutlet UIView *staffView;
@property (nonatomic, retain) IBOutlet UIView *topMenu;
@property (nonatomic, retain) IBOutlet UIButton *instrumentsButton;
@property (nonatomic, retain) IBOutlet UIButton *sharpFlatButton;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIView *popoverView;

@property (nonatomic, retain) NSMutableDictionary *lines;
@property (nonatomic, retain) NSMutableDictionary *spaces;
@property (nonatomic, retain) NSMutableDictionary *dots;
@property (nonatomic, retain) NSArray *notes;

- (void)buildStaff;
- (void)buildLines;
- (void)buildTopMenu;
- (void)setLineTags;
- (void)buildSpaces;
- (void)setSpaceTags;
- (BOOL)changeScale:(NSArray *)notesFromDataController;
- (void)setFlatsAndSharps;
- (void)setFlatsAndSharpsAndDots;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)clearAllSharpsAndFlatsFromStaff;
- (BOOL)setFlatOrSharpOnSpecificLineOrSpace:(int)num withNotePosition:(int)pos;
- (void)findAccidentalNote:(int)pos;
- (void)registerAccidentalNote:(UIView *)view withPos:(int)pos;
- (void)setDotAt:(int)location;

- (UIView *)deepCopySolidAccidentalView:(solidlineAccidental *)theView;
- (UIView *)deepCopyDashedAccidentalView:(dashedlineAccidental *)theView;



@end
