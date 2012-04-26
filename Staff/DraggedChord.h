//
//  DraggedChord.h
//  COMP150ISWFinalProject
//
//  Created by Hu Huang on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DraggedChord : UIView
{
    UIImageView *theImage;
    UILabel *theChord;
    Chord *_chordToPlay;
    int _indexOfChord;
}

@property (retain) Chord *chordChosen;
@property int indexOfChord;

-(void) changeChordName:(NSString *)chord;
-(NSString *) chordName;

@end
