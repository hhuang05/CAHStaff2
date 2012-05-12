//
//  Chord.h
//  Staff
//
//  Created by Aaron Tietz on 3/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chord : NSObject

@property (nonatomic, copy) NSArray *notes;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) int beatsPerMeasure;
@property (nonatomic) int numberOfMeasures;
@property (nonatomic) int idNumber;
@property (nonatomic, copy) NSString* key;
@property (nonatomic, copy) NSString* rootKey;


-(id)initWithName:(NSString*)name Notes:(NSArray*)notes andID:(int)number;
-(id)initWithName:(NSString*)aName Notes:(NSArray*)someNotes rootKey:(NSString*)root andKey:(NSString*)aKey;
-(void)resetValues;

@end
