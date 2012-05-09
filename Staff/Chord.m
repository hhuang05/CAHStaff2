//
//  Chord.m
//  Staff
//
//  Created by Aaron Tietz on 3/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "Chord.h"

@implementation Chord

@synthesize name, notes, beatsPerMeasure, numberOfMeasures, idNumber, key,rootKey;

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

-(id)initWithName:(NSString*)aName Notes:(NSArray*)someNotes rootKey:(NSString*)root andKey:(NSString*)aKey{
    self = [super init];
    
    if(self){
        name = [aName copy];
        notes = [someNotes copy];
        key = [aKey copy];
        beatsPerMeasure = 1;
        numberOfMeasures = 1;
        rootKey = [root copy];
    }
    
    return self;
}

-(void)setupKey:(NSString*)aKey{
    key = [aKey copy];
}

-(void)resetValues
{
    beatsPerMeasure = 1;
    numberOfMeasures = 1;
}

@end
