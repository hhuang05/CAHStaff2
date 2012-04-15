//
//  Chord.h
//  Staff
//
//  Created by Aaron Tietz on 3/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chord : NSObject{
    int number;
    int beatsPerMeasure;
    int numberOfMeasures;
}

@property (nonatomic, retain) NSArray *notes;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) int beats;
@property (nonatomic) int measures;

-(id)initWithName:(NSString*)name Notes:(NSArray*)notes andID:(int)number;
-(void)resetValues;
@end
