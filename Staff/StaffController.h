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
#import "AccidentalsController.h"


#define NUMBER_OF_NOTES 15
#define ICON_COUNT 7

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
    UIButton *sharpFlatButton;
    UIPopoverController *popoverController;
    UIView *popoverView;
    AccidentalsController *accidentalsController;
    
    @private
    NSMutableDictionary *lines;
    NSMutableDictionary *spaces;
    NSMutableDictionary *sharps;
    NSMutableDictionary *flats;
    NSArray *notes;
    
}

@property (nonatomic, retain) IBOutlet UIView *canvas;
@property (nonatomic, retain) IBOutlet UIView *staffView;
@property (nonatomic, retain) IBOutlet UIView *topMenu;
@property (nonatomic, retain) IBOutlet UIButton *sharpFlatButton;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIView *popoverView;

@property (nonatomic, retain) NSMutableDictionary *lines;
@property (nonatomic, retain) NSMutableDictionary *spaces;
@property (nonatomic, retain) NSArray *notes;

- (void)buildStaff;
- (void)buildLines;
- (void)setLineTags;
- (void)buildSpaces;
- (void)setSpaceTags;
- (BOOL)changeScale:(NSArray *)notesFromDataController;
- (void)setFlatsAndSharps;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)clearAllSharpsAndFlatsFromStaff;
- (BOOL)setFlatOrSharpOnSpecificLineOrSpace:(int)num withNotePosition:(int)pos;






@end
