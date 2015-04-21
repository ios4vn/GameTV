//
//  Utils.m
//  Fonext
//
//  Created by dungnv9 on 29/09/2014.
//  Copyright (c) 2014 dungnv9. All rights reserved.
//

#import "Utils.h"
static Utils        *_ut = nil;

@implementation Utils

+ (Utils *)shareInstance
{
    if (!_ut)
    {
        _ut = [[Utils alloc] init];
    }
    return _ut;
}

- (void)showLoadingView
{
    runOnMainQueueWithoutDeadlocking(^{
        if (HUD == nil)
        {
            
            HUD = [[MBProgressHUD alloc] initWithView:SharedAppDelegate.window];
            [SharedAppDelegate.window addSubview:HUD];
            
            
        }
        HUD.labelText = nil;//@"Wait a moment...";
        HUD.animationType = MBProgressHUDAnimationFade;
        HUD.dimBackground = YES;
        HUD.userInteractionEnabled = YES;
        [HUD show:YES];
        [SharedAppDelegate.window bringSubviewToFront:HUD];
    });
}

- (void)hideLoadingView
{
    runOnMainQueueWithoutDeadlocking(^{
        [HUD performSelectorOnMainThread:@selector(hide:) withObject:nil waitUntilDone:NO ];
        HUD = nil;
    });
}
@end
