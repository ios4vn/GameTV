//
//  SinglePlayer.h
//  Music
//
//  Created by Hai Trieu on 5/9/13.
//  Copyright (c) 2013 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol SinglePlayerDelegate <NSObject>

-(void)playerDidFinishSong;

@end

@interface SinglePlayer : NSObject {
    AVPlayer *player;
}

@property (nonatomic, strong) id<SinglePlayerDelegate> delegate;
@property (nonatomic, strong) AVPlayer *player;
+(SinglePlayer *)sharedInstance;
+(BOOL) isPlaying;
+(void) activePlayAndRecord;
+(void) activePlayback;
+(void)initSession;
-(void) playWithPath:(NSString*)path;
-(void) pause;
-(void) play;

@end
