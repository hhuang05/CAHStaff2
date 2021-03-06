//
//  ViewController.m
//  Staff
//
//  Created by Christopher Harris on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "StaffController.h"
#import "AccidentalsController.h"

@implementation StaffController

@synthesize canvas;
@synthesize staffView;
@synthesize topMenu;
@synthesize lines;
@synthesize spaces;
@synthesize dots;
@synthesize notes;
@synthesize instrumentsButton;
@synthesize sharpFlatButton;
@synthesize popoverView;
@synthesize popoverController;


-(id)init{
    [self viewDidLoad];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.notes = NULL;
    currentDotLocation = 0;
    [self buildStaff];
    [self buildLines];
    [self buildSpaces];
    [self buildTopMenu];
    [self setFlatsAndSharpsAndDots];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)buildStaff
{   
    self.canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 748)];
    self.staffView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 748)];
    [self.staffView setBackgroundColor:[UIColor clearColor]];
    [[staffView layer] setZPosition:1];
    self.view = self.canvas;
    
    UIImageView *trebleclef = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trebleclef.png"]];
    [trebleclef setFrame:CGRectMake(81, 227, 131, 367)];
    [[trebleclef layer] setZPosition:1];
    [self.canvas setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"papyrus.jpg"]]];
    [self.canvas addSubview:trebleclef];
    [self.canvas addSubview:staffView];
    
    //wrinkledPaper = [UIImage imageNamed:@"CrinkledPaper.png"];
}

-(void)setLineTags
{
    [[lines objectForKey:@"aline"] setTag:2];
    [[lines objectForKey:@"fline"] setTag:4];
    [[lines objectForKey:@"dline"] setTag:6];
    [[lines objectForKey:@"bline"] setTag:8];
    [[lines objectForKey:@"gline"] setTag:10];
    [[lines objectForKey:@"eline"] setTag:12];
    [[lines objectForKey:@"cline"] setTag:14];
}

- (void)buildTopMenu
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    topMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 70)];
    [topMenu setBackgroundColor:[UIColor colorWithRed:100.0/255 green:100.0/255 blue:100.0/255 alpha:1.0]];
    
    sharpFlatButton = [[UIButton alloc] initWithFrame:CGRectMake(325, 10, 50, 50)];
    [sharpFlatButton setBackgroundColor:[UIColor colorWithRed:170.0/255 green:170.0/255 blue:170.0/255 alpha:1.0]];
    [[sharpFlatButton layer] setBorderColor:[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:1.0].CGColor];
    [[sharpFlatButton layer] setBorderWidth:1];
    [[sharpFlatButton layer] setCornerRadius:10];
    [sharpFlatButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [sharpFlatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sharpFlatButton setTitle:@"-" forState:UIControlStateNormal];
    [mainDelegate.viewController.accidentalsController setState:0];
    [[sharpFlatButton layer] setBorderColor:[UIColor blackColor].CGColor];
    [[sharpFlatButton layer] setBorderWidth:2];
    [[sharpFlatButton layer] setShadowColor:[UIColor blackColor].CGColor];
    [[sharpFlatButton layer] setShadowOpacity:0.7f];
    [[sharpFlatButton layer] setShadowOffset:CGSizeMake(3.0f, 3.0f)];
    [[sharpFlatButton layer] setShadowRadius:5.0f];
    [[sharpFlatButton layer] setMasksToBounds:NO];
    [[sharpFlatButton layer] setShadowPath:[UIBezierPath bezierPathWithRect:sharpFlatButton.bounds].CGPath];
    
    instrumentsButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 280, 50)];
    [instrumentsButton setBackgroundColor:[UIColor colorWithRed:170.0/255 green:170.0/255 blue:170.0/255 alpha:1.0]];
    [[instrumentsButton layer] setBorderColor:[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:1.0].CGColor];
    [[instrumentsButton layer] setBorderWidth:1];
    [[instrumentsButton layer] setCornerRadius:10];
    [instrumentsButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [instrumentsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [instrumentsButton setTitle:@"Acoustic Piano" forState:UIControlStateNormal];
    [mainDelegate.viewController.accidentalsController setState:0];
    [[instrumentsButton layer] setBorderColor:[UIColor blackColor].CGColor];
    [[instrumentsButton layer] setBorderWidth:2];
    [[instrumentsButton layer] setShadowColor:[UIColor blackColor].CGColor];
    [[instrumentsButton layer] setShadowOpacity:0.7f];
    [[instrumentsButton layer] setShadowOffset:CGSizeMake(3.0f, 3.0f)];
    [[instrumentsButton layer] setShadowRadius:5.0f];
    [[instrumentsButton layer] setMasksToBounds:NO];
    [[instrumentsButton layer] setShadowPath:[UIBezierPath bezierPathWithRect:instrumentsButton.bounds].CGPath];
    
    [topMenu addSubview:instrumentsButton];
    [topMenu addSubview:sharpFlatButton];
    [self.canvas addSubview:topMenu];
    [instrumentsButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openInstrumentsMenu:)]];
    [sharpFlatButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openAccidentalMenu:)]];
    
}

- (IBAction)openAccidentalMenu:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([popoverController isPopoverVisible]){
        [popoverController dismissPopoverAnimated:YES];
        return;
    }
    popoverController = [[UIPopoverController alloc] initWithContentViewController:mainDelegate.viewController.accidentalsController];
    [popoverController presentPopoverFromBarButtonItem:sender 
                   permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [popoverController setPopoverContentSize:CGSizeMake(320, 216)];
}

- (IBAction)openInstrumentsMenu:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([popoverController isPopoverVisible]){
        [popoverController dismissPopoverAnimated:YES];
        return;
    }
    popoverController = [[UIPopoverController alloc] initWithContentViewController:mainDelegate.viewController.instrumentsController];
    [popoverController presentPopoverFromBarButtonItem:sender 
                              permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [popoverController setPopoverContentSize:CGSizeMake(320, 216)];
}

- (void)buildLines
{
    lines = [[NSMutableDictionary alloc] initWithCapacity:7];
     
    solidlineAccidental *solidLineAccidental = [[solidlineAccidental alloc] initWithFrame:CGRectMake(300, 0, 100, 28)];
    dashedlineAccidental *dashedLineAccidental = [[dashedlineAccidental alloc] initWithFrame:CGRectMake(300, 0, 100, 28)];
    
    dashedLine *aline = [[dashedLine alloc] initWithFrame:CGRectMake(0, 123, 400, 28)];
    [[aline layer] setZPosition:2];
    [aline addSubview:[self deepCopyDashedAccidentalView:dashedLineAccidental]];
    [lines setObject:aline forKey:@"aline"];
    
    solidLine *fline = [[solidLine alloc] initWithFrame:CGRectMake(0, 214, 400, 28)];
    [[fline layer] setZPosition:2];
    [fline addSubview:[self deepCopySolidAccidentalView:solidLineAccidental]];
    [lines setObject:fline forKey:@"fline"];

    solidLine *dline = [[solidLine alloc] initWithFrame:CGRectMake(0, 305, 400, 28)];
    [[dline layer] setZPosition:2];
    [dline addSubview:[self deepCopySolidAccidentalView:solidLineAccidental]];
    [lines setObject:dline forKey:@"dline"];

    solidLine *bline = [[solidLine alloc] initWithFrame:CGRectMake(0, 396, 400, 28)];
    [[bline layer] setZPosition:2];
    [bline addSubview:[self deepCopySolidAccidentalView:solidLineAccidental]];
    [lines setObject:bline forKey:@"bline"];

    solidLine *gline = [[solidLine alloc] initWithFrame:CGRectMake(0, 487, 400, 28)];
    [[gline layer] setZPosition:2];
    [gline addSubview:[self deepCopySolidAccidentalView:solidLineAccidental]];
    [lines setObject:gline forKey:@"gline"];

    solidLine *eline = [[solidLine alloc] initWithFrame:CGRectMake(0, 578, 400, 28)];
    [[eline layer] setZPosition:2];
    [eline addSubview:[self deepCopySolidAccidentalView:solidLineAccidental]];
    [lines setObject:eline forKey:@"eline"];

    dashedLine *cline = [[dashedLine alloc] initWithFrame:CGRectMake(0, 669, 400, 28)];
    [[cline layer] setZPosition:2];
    [cline addSubview:[self deepCopyDashedAccidentalView:dashedLineAccidental]];
    [lines setObject:cline forKey:@"cline"];
    
    [self setLineTags];
    
    NSEnumerator *enumerator = [lines keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        UIView *line = [lines objectForKey:key];
        [line setBackgroundColor:[UIColor clearColor]];
        [canvas addSubview:line];
    }
}

- (UIView *)deepCopyAccidentalView:(UIView *)theView
{
    UIView *newView = [[UIView alloc] initWithFrame:[theView frame]];
    [newView setBackgroundColor:[UIColor lightGrayColor]];
    [newView setAlpha:0.5f];
    return newView;
}

- (UIView *)deepCopySolidAccidentalView:(solidlineAccidental *)theView
{
    solidlineAccidental *newView = [[solidlineAccidental alloc] initWithFrame:[theView frame]];
    [newView setBackgroundColor:[UIColor lightGrayColor]];
    [newView setAlpha:0.5f];
    return newView;
}

- (UIView *)deepCopyDashedAccidentalView:(dashedlineAccidental *)theView
{
    dashedlineAccidental *newView = [[dashedlineAccidental alloc] initWithFrame:[theView frame]];
    [newView setBackgroundColor:[UIColor lightGrayColor]];
    [newView setAlpha:0.5f];
    return newView;
}

- (void)registerAccidentalNote:(UIView *)view withPos:(int)pos
{
    
}

- (void)buildSpaces
{
    spaces = [[NSMutableDictionary alloc] initWithCapacity:8];
    UIView *accidentalabove = [[UIView alloc] initWithFrame:CGRectMake(300, 0, 100, 53)];
    UIView *accidental = [[UIView alloc] initWithFrame:CGRectMake(300, 0, 100, 63)];
    [accidentalabove setBackgroundColor:[UIColor lightGrayColor]];
    [accidental setBackgroundColor:[UIColor lightGrayColor]];
    
    UIView *b2space = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 400, 53)];
    [b2space addSubview:[self deepCopyAccidentalView:accidentalabove]];
    [spaces setObject:b2space forKey:@"b2space"];
    
    UIView *gspace = [[UIView alloc] initWithFrame:CGRectMake(0, 151, 400, 63)];
    [gspace addSubview:[self deepCopyAccidentalView:accidental]];
    [spaces setObject:gspace forKey:@"gspace"];
    
    UIView *espace = [[UIView alloc] initWithFrame:CGRectMake(0, 242, 400, 63)];
    [espace addSubview:[self deepCopyAccidentalView:accidental]];
    [spaces setObject:espace forKey:@"espace"];
    
    UIView *cspace = [[UIView alloc] initWithFrame:CGRectMake(0, 333, 400, 63)];
    [cspace addSubview:[self deepCopyAccidentalView:accidental]];
    [spaces setObject:cspace forKey:@"cspace"];
    
    UIView *aspace = [[UIView alloc] initWithFrame:CGRectMake(0, 424, 400, 63)];
    [aspace addSubview:[self deepCopyAccidentalView:accidental]];
    [spaces setObject:aspace forKey:@"aspace"];
    
    UIView *fspace = [[UIView alloc] initWithFrame:CGRectMake(0, 515, 400, 63)];
    [fspace addSubview:[self deepCopyAccidentalView:accidental]];
    [spaces setObject:fspace forKey:@"fspace"];
    
    UIView *dspace = [[UIView alloc] initWithFrame:CGRectMake(0, 606, 400, 63)];
    [dspace addSubview:[self deepCopyAccidentalView:accidental]];
    [spaces setObject:dspace forKey:@"dspace"];
    
    UIView *bspace = [[UIView alloc] initWithFrame:CGRectMake(0, 697, 400, 53)];
    [bspace addSubview:[self deepCopyAccidentalView:accidentalabove]];
    [spaces setObject:bspace forKey:@"bspace"];
    
    [self setSpaceTags];
  
    NSEnumerator *enumerator = [spaces keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        UIView *space = [spaces objectForKey:key];
        [space setBackgroundColor:[UIColor clearColor]];
        [canvas addSubview:space];
    }
}

- (void)setSpaceTags
{
    [[spaces objectForKey:@"b2space"] setTag:1];
    [[spaces objectForKey:@"gspace"] setTag:3];
    [[spaces objectForKey:@"espace"] setTag:5];
    [[spaces objectForKey:@"cspace"] setTag:7];
    [[spaces objectForKey:@"aspace"] setTag:9];
    [[spaces objectForKey:@"fspace"] setTag:11];
    [[spaces objectForKey:@"dspace"] setTag:13];
    [[spaces objectForKey:@"bspace"] setTag:15];
}

- (BOOL)changeScale:(NSArray *)notesFromDataController
{
    //Return false if array is not normalized properly
    if(notesFromDataController.count != NUMBER_OF_NOTES + 1){
        NSLog(@" Recieved this number of notes: %@", [notesFromDataController count]);
        return FALSE;
    }
    
    //Parse values for validity first
    int num = -1;
    for(int i = 1; i < NUMBER_OF_NOTES + 1; i++)
    {
        num = [[notesFromDataController objectAtIndex:i] integerValue];
        if(num != -1 && num != 0 && num != 1){
            NSLog(@"Invalid Number: %d",num);
            return FALSE;
        }
        
    }
    
    //Reset staff with no icons
    [self clearAllSharpsAndFlatsFromStaff];
    
    num = -1;
    
    //For each, display flat/sharp if value -1/1
    for(int pos = 1; pos < NUMBER_OF_NOTES + 1; pos++)
    {
        num = [[notesFromDataController objectAtIndex:pos] intValue];
        if(num != 0){
            //NSLog(@"value: %d pos: %d",[[notesFromDataController objectAtIndex:pos] intValue], pos);            
            [self setFlatOrSharpOnSpecificLineOrSpace:num withNotePosition:pos + 1];
            [self findAccidentalNote:pos + 1];
        }
    }
    
    int newDotLocation = [[notesFromDataController objectAtIndex:0] intValue];
    //NSLog(@"DOT IS: %d",newDotLocation);
    [self setDotAt: newDotLocation];
    currentDotLocation = newDotLocation;
    //NSLog(@"root note %d", currentDotLocation);
    
    return TRUE;
}

-(void)setDotAt:(int)location
{
    // hide old dot
    
    [[dots objectForKey:[[NSString alloc] initWithFormat:@"%d", currentDotLocation+4]] setHidden:TRUE];  
    
    // show new dot
    //NSLog(@"Dot LOC: %d",location);
    //NSLog(@"Dot STR: %@", [[NSString alloc] initWithFormat:@"%d", location]);
    //NSLog(@"Dot OBJ: %@",[dots objectForKey:[[NSString alloc] initWithFormat:@"%d", location]]);
    [[dots objectForKey:[[NSString alloc] initWithFormat:@"%d", location+4]] setHidden:FALSE];
}

- (void)findAccidentalNote:(int)pos
{
    id key;
    if((pos % 2) == 1){
        NSEnumerator *senumerator = [spaces keyEnumerator];
        while ((key = [senumerator nextObject])) {
            UIView *subview = [spaces objectForKey:key];
            if(pos == [subview tag]){
                [self registerAccidentalNote:subview withPos:pos];
                return;
            }
        }
    } else {
        NSEnumerator *lenumerator = [lines keyEnumerator];
        while ((key = [lenumerator nextObject])) {
            UIView *subview = [lines objectForKey:key];
            if(pos == [subview tag]){
                [self registerAccidentalNote:subview withPos:pos];
                return;
            }
        }
    }
}

- (void)clearAllSharpsAndFlatsFromStaff
{   
    int sharpNum = 3;
    int flatNum = 5;
    UIImageView *icon = NULL;
    
    for(int pos = 0; pos < ICON_COUNT+1; pos++)
    {
        icon = [sharps objectForKey:[NSString stringWithFormat:@"%d",pos+sharpNum]];
        if(icon){
            [icon setHidden:TRUE];
        }
        icon = [flats objectForKey:[NSString stringWithFormat:@"%d",pos+flatNum]];
        if(icon){
            [icon setHidden:TRUE];
        }
        
    }
}

- (BOOL)setFlatOrSharpOnSpecificLineOrSpace:(int)num withNotePosition:(int)pos
{
    
    NSString *type = (num < 0) ? @"flat" : @"sharp";
   
    /*
    NSLog(@"NUM: %d",num);
    NSLog(@"TYPE: %@",type);
    NSLog(@"POS: %d",pos);
    */
    
    if(type == @"sharp" && (pos < 3 || pos > 10)){
        NSLog(@"Error: No sharp for note position: %d",pos);
        return FALSE;
    }
    else if(type == @"flat" && (pos < 5 || pos > 12)){
        NSLog(@"Error: No flat for note position: %d",pos);
        return FALSE; 
    }
    
    UIImageView *icon = (type == @"sharp") ? [sharps objectForKey:[NSString stringWithFormat:@"%d",pos]] : 
        [flats objectForKey:[NSString stringWithFormat:@"%d",pos]];
    [icon setHidden:FALSE];
    return TRUE;
}

- (void)setFlatsAndSharpsAndDots
{
    IVM sharpData, flatData, dotData;
    int d_width = 40;
    int d_height = 40;
    int d_x = 5;

    sharpData.width = d_width;
    sharpData.height = d_height;
    sharpData.x = d_x;
    sharpData.y = 117;
    flatData.width = d_width;
    flatData.height = d_height;
    flatData.x = d_x;
    flatData.y = 201;
    
    dotData.width = d_width;
    dotData.height = d_height;
    dotData.x = 380;
    dotData.y = 74;
    
    int sharpNoteCount = 3;
    int flatNoteCount = 5;
    int dotCount = 3;
    
    sharps = [[NSMutableDictionary alloc] initWithCapacity:ICON_COUNT];
    flats = [[NSMutableDictionary alloc] initWithCapacity:ICON_COUNT];
    dots = [[NSMutableDictionary alloc] initWithCapacity:NUMBER_OF_NOTES];
    
    for (int i = 0; i < ICON_COUNT; i++) {
        //Add sharp icons to staffView, hide all
        UIImageView *sharp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notassmallsharp.png"]];
        [sharp setFrame:CGRectMake(sharpData.x, sharpData.y, sharpData.width, sharpData.height)];
        [sharp setHidden:TRUE];
        [[sharp layer] setZPosition:3];
        //[self fadeOut : sharp withDuration: 3 andWait : 1 ];
        [sharps setValue:sharp forKey:[NSString stringWithFormat:@"%d",sharpNoteCount]];
        [canvas addSubview:sharp];
        
        if(i == 5){
            sharpData.y += 92;
            sharpNoteCount += 2;
        } else {
            sharpData.y += 46;
            sharpNoteCount += 1;
        }
        
    }
    
    for (int i = 0; i < ICON_COUNT; i++) {
        //Add flat icons to staffView, hide all
        UIImageView *flat = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notassmallflat.png"]];
        [flat setFrame:CGRectMake(flatData.x, flatData.y, flatData.width, flatData.height)];
        [flat setHidden:TRUE];
        [[flat layer] setZPosition:3];
        //[self fadeOut : flat withDuration: 3 andWait : 1 ];
        [flats setValue:flat forKey:[NSString stringWithFormat:@"%d",flatNoteCount]];
        [canvas addSubview:flat];
        
        flatData.y += 46;
        flatNoteCount +=1;
        
    }
    
    for(int i = 0; i < NUMBER_OF_NOTES; i++){
        //Add dot icons to staffView, hide all
        UIImageView *dot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scaledot.png"]];
        [dot setFrame:CGRectMake(dotData.x, dotData.y, dotData.width, dotData.height)];
        [dot setHidden:TRUE];
        [[dot layer] setZPosition:3];
        //[self fadeOut : flat withDuration: 3 andWait : 1 ];
        [dots setValue:dot forKey:[NSString stringWithFormat:@"%d",dotCount+2]];
        [canvas addSubview:dot];
        
        dotData.y += 46;
        if(fmod(i,2) == 0){
            dotData.y -= 1;
        }
        dotCount += 1;
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"# of Touches: %d",[touches count]);
    NSArray *allTouches = [touches allObjects];
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if(numtouches < MAXTOUCHES){
        for (UITouch *touch in allTouches)
        {
            if(touch.view.tag > 0){
               // NSLog(@"Began - Tag: %d",touch.view.tag);
                numtouches++;
                [mainDelegate.viewController.dataController playNoteAt:(touch.view.tag - 1) WithHalfStepAlteration:0];
     
            }
            else if(touch.view.superview.tag > 0){
                numtouches++;
              //  NSLog(@"Began - Tag: %d",touch.view.tag);
               // NSLog(@"state: %d",mainDelegate.viewController.accidentalsController.state);
                [mainDelegate.viewController.dataController playNoteAt:(touch.view.superview.tag - 1) WithHalfStepAlteration:mainDelegate.viewController.accidentalsController.state];
            }
        }
        
        [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            // Get a single touch and it's location
            
            UITouch *touch = obj;
            CGPoint touchPoint = [touch locationInView:self.view];
            
            // Draw a red circle where the touch occurred
            UIView *touchView = [[UIView alloc] init];
            [touchView setTag:666];
            [touchView setBackgroundColor:[UIColor colorWithRed:0.0/255 green:153.0/255 blue:255.0/255 alpha:0.6]];
            [touchView setFrame:CGRectMake(touchPoint.x-15, touchPoint.y-15, 30, 30)];
            [[touchView layer] setCornerRadius:15];
            touchView.layer.borderColor = [UIColor colorWithRed:221.0/255 green:221.0/255 blue:221.0/255 alpha:0.9].CGColor;
            [[touchView layer] setBorderWidth:2]; 
            [staffView addSubview:touchView];     
        }];
    }
    NSLog(@"num touch: %d",numtouches);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *allTouches = [touches allObjects];
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    for (UITouch *touch in allTouches){
        if(touch.view.tag > 0 && numtouches){
            [mainDelegate.viewController.dataController stopNote];
            numtouches--;
        }
         else if(touch.view.superview.tag > 0){
             [mainDelegate.viewController.dataController stopNote]; 
             numtouches--;
         }
    }
    
    NSArray *subviews = [self.staffView subviews];
    for (UIView *view in subviews){
        if(view.tag == 666){
            [view removeFromSuperview];
        }
    }
    NSLog(@"num touch: %d",numtouches);
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
