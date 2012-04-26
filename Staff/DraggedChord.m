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

- (id)init
{
    self = [super init];
    
    if (self) {
        // Initialization code
        // Add the image and the text
        theImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CyanSquare.png"]];
        [theImage setFrame:CGRectMake(0, 0, 80, 80)];
        [self addSubview:theImage];
        
        // added adjustsFontSizetoWidth and changed 3rd arg (width) from 46-70), 1st from 17 to 5
        theChord = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 70, 40)];
        // theChord.adjustsFontSizeToFitWidth = TRUE;
        // [theChord setFont:[UIFont systemFontOfSize:10]];
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

-(NSString *) chordName
{
    return theChord.text;
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
