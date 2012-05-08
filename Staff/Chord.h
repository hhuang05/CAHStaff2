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
@property (nonatomic, retain) NSString* rootKey;


-(id)initWithName:(NSString*)name Notes:(NSArray*)notes andID:(int)number;
-(id)initWithName:(NSString*)aName Notes:(NSArray*)someNotes rootKey:(NSString*)root andKey:(NSString*)aKey;
-(void)setupKey:(NSString*)aKey;
-(void)resetValues;

@end
