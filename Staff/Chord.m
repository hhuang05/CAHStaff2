//
//  Chord.m
//  Staff
//
//  Created by Aaron Tietz on 3/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "Chord.h"

@implementation Chord

@synthesize name = _name, notes = _notes, beats = beatsPerMeasure, measures = numberOfMeasures;

-(id)initWithName:(NSString*)name Notes:(NSArray*)notes andID:(int)num{
    self = [super init];

    self.name = name;
    self.notes = notes;
    number = num;
    beatsPerMeasure = 1;
    numberOfMeasures = 1;

    return self;
}

@end
