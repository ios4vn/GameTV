//
//  SinglePlayer.m
//  Music
//
//  Created by Hai Trieu on 5/9/13.
//  Copyright (c) 2013 Adriaenssen BVBA. All rights reserved.
//

#import "SinglePlayer.h"

@implementation SinglePlayer

@synthesize player;

static SinglePlayer *sharedInstance = nil;

+ (SinglePlayer *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}
+(BOOL) isPlaying{
    return YES;
}

void audioRouteChangeListenerCallback ( void     *inUserData,AudioSessionPropertyID    inPropertyID,                                       UInt32                    inPropertyValueSize,                                       const void                *inPropertyValue );
//implementation
void audioRouteChangeListenerCallback (                                       void                      *inUserData,AudioSessionPropertyID    inPropertyID,                                       UInt32                    inPropertyValueSize,                                       const void                *inPropertyValue ) {
    
    // ensure that this callback was invoked for a route change
    if (inPropertyID != kAudioSessionProperty_AudioRouteChange) return;
    
    // Determines the reason for the route change,
    // to ensure that it is not because of a category change.
    CFDictionaryRef routeChangeDictionary = inPropertyValue;
    CFNumberRef routeChangeReasonRef = CFDictionaryGetValue ( routeChangeDictionary,CFSTR (kAudioSession_AudioRouteChangeKey_Reason) );
    SInt32 routeChangeReason;
    CFNumberGetValue (routeChangeReasonRef, kCFNumberSInt32Type, &routeChangeReason);
    
    // "Old device unavailable"
    // headset was unplugged, or device was removed from a dock connector
    // that supports audio output. A test for when audio is paused
    
    //    AVPlayer *playerInstance = (__bridge AVPlayer*) inUserData;
    
    if (routeChangeReason == kAudioSessionRouteChangeReason_OldDeviceUnavailable) {
        // player might respond appropriately - pause
    } else if (routeChangeReason == kAudioSessionRouteChangeReason_NewDeviceAvailable){
        //audio plugged back in, player might respond appropriately - play }
    }
}

+(void)initSession
{
    
    // Registers this class as the delegate of the audio session to listen for audio interruptions
    [[AVAudioSession sharedInstance] setDelegate: self];
    // An instance of the audio player/manager is passed to the listener
    AudioSessionAddPropertyListener ( kAudioSessionProperty_AudioRouteChange,
                                     audioRouteChangeListenerCallback, (__bridge void *)(self) );
    
    [self activePlayback];
}

+(void) activePlayAndRecord{
    //Set the audio category of this app to playback.
    NSError *setCategoryError = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: &setCategoryError];
    if (setCategoryError) {
        NSLog(@"avaudiosession %@",setCategoryError);
    }
    
    // Registers the audio route change listener callback function
    
    
    //Activate the audio session
    NSError *activationError = nil;
    [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
    if (activationError) {
        NSLog(@"avaudio activation %@",activationError);
    }
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute,
                            sizeof(audioRouteOverride), &audioRouteOverride);
}

+(void) activePlayback{
    //Set the audio category of this app to playback.
    NSError *setCategoryError = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryError];
    if (setCategoryError) {
        NSLog(@"avaudiosession %@",setCategoryError);
    }
    
    // Registers the audio route change listener callback function
    
    //Activate the audio session
    NSError *activationError = nil;
    [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
    if (activationError) {
        NSLog(@"avaudio activation %@",activationError);
    }
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute,
                            sizeof(audioRouteOverride), &audioRouteOverride);
}

- (id)init
{
    self = [super init];
    
    if (self) {

    }
    
    return self;
}

-(void) pause{
    [player pause];
}

-(void) play{
    [player play];
}

-(void) playWithPath:(NSString*)path{
    NSURL *urlStream = [NSURL URLWithString:path];
    player = [AVPlayer playerWithURL:urlStream];
}

@end
