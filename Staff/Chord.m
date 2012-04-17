//
//  Chord.m
//  Staff
//
//  Created by Aaron Tietz on 3/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "Chord.h"

@implementation Chord

@synthesize name, notes, beatsPerMeasure, numberOfMeasures, idNumber;

-(id)initWithName:(NSString*)aName Notes:(NSArray*)someNotes andID:(int)num{
    self = [super init];

    if(self){
        name = aName;
        notes = someNotes;
        idNumber = num;
        beatsPerMeasure = 1;
        numberOfMeasures = 1;
    }

    return self;
}

-(void)resetValues
{
    beatsPerMeasure = 1;
    numberOfMeasures = 1;
}

@end
