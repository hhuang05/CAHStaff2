//
//  AppDelegate.m
//  Staff
//
//  Created by Christopher Harris on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AudioToolBox/AudioServices.h>
#import "AppDelegate.h"
#import "MainController.h"

// uncomment to run with attempt 2
//
//static CRMD_FUNC staticCRMD_FUNC;

@interface AppDelegate (Private)
- (void)callback:(CRMD_CALLBACK_TYPE) type data:(void *)data;
@end

static void _callback (CRMD_HANDLE handle, CRMD_CALLBACK_TYPE type, void *data, void *user)
{
    // __bridge was added after an error message requested the change for reference counting reasons
	AppDelegate *appDelegate = (__bridge AppDelegate *) user;
	[appDelegate callback:type data:data];
}

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize mix = _mix, handle = _handle, _api, midiFunctions = _midiFunctions;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // set up MIDI API
    // bridged void* cast added in response to error message
    AudioSessionInitialize(NULL, NULL, NULL, (__bridge void*) self);
	UInt32 category = kAudioSessionCategory_AmbientSound;
	AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
    
	AudioSessionSetActive(true);
    
	Float32 bufferSize = 0.005;
	SInt32 size = sizeof(bufferSize);
	AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareIOBufferDuration, size, &bufferSize);
    
	_api = crmdLoad ();

     /*  ADD COMMENTS TO THE LINE ABOVE AND UNCOMMENT ONE OF MY THREE SUGGESSTED SOULTIONS BELOW
      
      _api is a CRMD_FUNC*, and CRMD_FUNC is C struct with funcion pointers to the functions we'll call 
      
      these relevant declarations are in crmd.h:
      
      typedef CRMD_FUNC* (*CRMD_LOAD) (void);
      CRMD_FUNC *crmdLoad (void); 
      
      In short, we need to allocate a struct of type CRMD_FUNC (see crmd.h) that contains
      function pointers to the MIDI functions.  I rewrote the line they gave us below.
      
      */
    
    // 1.
    // - caused EXC_BAD_ACCESS on the "err = _api->..." assignemnt below  the key[64]
    //
    //_api = (CRMD_FUNC*)malloc(sizeof(CRMD_FUNC));
    
    // 2. 
    // see declaration near top of file - I needed a struct that would live beyond the method call
    // - caused EXC_BAD_ACCESS on the "err = _api->..." assignemnt below  the key[64]
    //
    //_api = &staticCRMD_FUNC;
    
	CRMD_ERR err = CRMD_OK;
	
	if (err == CRMD_OK) {
		// initialize
		NSString *path = [[NSBundle mainBundle] pathForResource:@"crsynth" ofType:@"dlsc"];
		const char *lib = [path cStringUsingEncoding:NSASCIIStringEncoding];
        const unsigned char key[64] = {
            0xE1, 0xF1, 0x4B, 0xF9, 0x39, 0xA7, 0x6C, 0x32,
            0x65, 0x73, 0x1B, 0xF5, 0xD0, 0x00, 0xD8, 0xAD,
            0x70, 0x07, 0x52, 0xF3, 0x22, 0x68, 0x52, 0xF2,
            0x6B, 0xE6, 0x4A, 0x54, 0x0E, 0xE4, 0xA6, 0xE6,
            0x4B, 0xF0, 0x81, 0x82, 0x33, 0xE7, 0xF9, 0xA3,
            0xB1, 0x39, 0xFE, 0xB1, 0x7D, 0xAA, 0xA9, 0x44,
            0x74, 0x68, 0xF7, 0x79, 0xD0, 0xF2, 0xED, 0x2D,
            0xE4, 0x62, 0x89, 0x45, 0x9F, 0xC7, 0xA5, 0x62,
		};
		err = _api->initializeWithSoundLib (&_handle, _callback, (__bridge void *) self, lib, NULL, key);
        
        // 3.
        // used a CRMD_FUNC member variable - caused EXC_BAD_ACCESS on this call
        //err = _midiFunctions.initializeWithSoundLib (&_handle, _callback, (__bridge void *) self, lib, NULL, key);
	}
    
	if (err == CRMD_OK) {
		// revweb on
		int value = 1;
		err = _api->ctrl (_handle, CRMD_CTRL_SET_REVERB, &value, sizeof (value));
	}
    
	if (err == CRMD_OK) {
		// open wave output device
		err = _api->open (_handle, NULL, NULL);
	}
    
	if (err == CRMD_OK) {
		// start realtime MIDI
		err = _api->start (_handle);
	}

    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[MainController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    
    //[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
	_api->stop (_handle);
	_api->close (_handle);
	_api->exit (_handle);
}

- (void)callback:(CRMD_CALLBACK_TYPE) type data:(void *)data
{
	switch (type) {
        case CRMD_CALLBACK_TYPE_OPEN:
            NSLog (@"opened");
            break;
        case CRMD_CALLBACK_TYPE_CLOSE:
            NSLog (@"closeed");
            break;
        case CRMD_CALLBACK_TYPE_START:
            NSLog (@"started");
            break;
        case CRMD_CALLBACK_TYPE_STOP:
            NSLog (@"stopped");
            break;
        case CRMD_CALLBACK_TYPE_FRAME:
            if (_mix) {
                CRMD_FRAME *frame = (CRMD_FRAME *) data;
                static unsigned long n = 0;
                
                short *data = (short *) frame->data;
                long sampleFrames = frame->sampleFrames;
                while (--sampleFrames >= 0L) {
                    short value = (short) (8192.f * sinf  (2.f  * M_PI * 440.f * (float) n++ / 22050.f));
                    *data++ += value;
                    *data++ += value;
                }
                
            }
            break;
        case CRMD_CALLBACK_TYPE_FILE_START:
            NSLog (@"player started");
            break;
        case CRMD_CALLBACK_TYPE_FILE_STOP:
            NSLog (@"player stopped");
            break;
        case CRMD_CALLBACK_TYPE_FILE_SEEK:
            NSLog (@"player seeked");
            break;
        case CRMD_CALLBACK_TYPE_CLOCK:
            break;
        case CRMD_CALLBACK_TYPE_TEMPO:
            NSLog (@"tempo = %lu[usec/beat]", *(unsigned long *) data);
            break;
        case CRMD_CALLBACK_TYPE_TIME_SIGNATURE:
            NSLog (@"set time signature = %lu", *(unsigned long *) data);
            break;
        case CRMD_CALLBACK_TYPE_CHANNEL_MESSAGE:
            break;
        case CRMD_CALLBACK_TYPE_SYSTEM_EXCLUSIVE_MESSAGE:
            break;
        default:
            break;
	}
}

@end
