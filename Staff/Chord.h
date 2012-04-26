//
//  Chord.h
//  Staff
//
//  Created by Aaron Tietz on 3/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chord : NSObject

@property (nonatomic, retain) NSArray *notes;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) int beatsPerMeasure;
@property (nonatomic) int numberOfMeasures;
@property (nonatomic) int idNumber;
@property (nonatomic, retain) NSString* key;

-(id)initWithName:(NSString*)name Notes:(NSArray*)notes andID:(int)number;
-(void)setupKey:(NSString*)aKey;
-(void)resetValues;

@end
