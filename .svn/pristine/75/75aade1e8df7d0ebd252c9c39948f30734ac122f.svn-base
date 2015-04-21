//
//  Utils.h
//  Fonext
//
//  Created by dungnv9 on 29/09/2014.
//  Copyright (c) 2014 dungnv9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef enum {
    HISTORY_MENU=0,
    DIAL_MENU,
    MESSAGE_MENU,
    CONTACT_MENU,
    ACCOUNT_MENU
}LEFT_MENU_TYPE;


#ifndef _PERFORM_BLOCK_ON_MAIN_THEAD
#define _PERFORM_BLOCK_ON_MAIN_THEAD(block) dispatch_async(dispatch_get_main_queue(), block)
#endif

static void runOnMainQueueWithoutDeadlocking(void (^block)(void))
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@interface Utils : NSObject
{
    MBProgressHUD *HUD;
}

+ (Utils *)shareInstance;
- (void)showLoadingView;
- (void)hideLoadingView;

@end
