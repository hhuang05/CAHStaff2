//
//  DraggedChord.m
//  COMP150ISWFinalProject
//
//  Created by Hu Huang on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "DraggedChord.h"

@implementation DraggedChord

@synthesize chordChosen = _chordToPlay, indexOfChord = _indexOfChord;

-(id) init
{
    self = [super init];
    
    if (self) {
        // Initialization code
        // Add the image and the text
        theImage = [[UIImageView alloc] init];
        [theImage setFrame:CGRectMake(0, 0, 110, 110)];
        [self addSubview:theImage];
        
        // added adjustsFontSizetoWidth and changed 3rd arg (width) from 46-70), 1st from 17 to 5
        theChord = [[UILabel alloc] initWithFrame:CGRectMake(18, 30, 70, 40)];
        // theChord.adjustsFontSizeToFitWidth = TRUE;
        [theChord setFont:[UIFont fontWithName:@"Noteworthy-Light" size:20.0f]];
        [theChord setTextAlignment:UITextAlignmentCenter];
        [theChord setBackgroundColor:[UIColor clearColor]];
        [theImage addSubview:theChord];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void) changeChordName:(NSString *)chord
{
    if (![chord isEqualToString:@""])
    {
        [theChord setText:chord];
    }
}

-(void) changeImageToNewImage:(UIImage *)newImage
{
    [theImage performSelectorOnMainThread:@selector(setImage:) withObject:newImage waitUntilDone:TRUE];
}

-(NSString *) chordName
{
    return theChord.text;
}

-(UIImage *) getCurrentImage
{
    return [theImage image];
}

-(UILabel *) getCurrentLabel
{
    return theChord;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
