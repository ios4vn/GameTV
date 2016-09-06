/*
 Copyright 2011-2015 PushWizard.com All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE PUSHWIZARD.COM ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL PUSHWIZARD OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PushWizard : UIViewController <UIApplicationDelegate, UIAlertViewDelegate>

// This method will register a device token on the PushWizard server, it is necessary for sending push messages in the future.
// The special app identifier 'appKey' is generated on the pushwizard.com website, when an app is added to the profile.
+ (void)startWithToken:(NSData *)deviceToken andAppKey:(NSString *)appKey andValues:(NSArray *)values;

// This method is a helper method. It is necessary for handling special requests, like URL Redirecting or Review Requests.
+ (void)handleNotification:(NSDictionary *)userInfo processOnlyStatisticalData:(BOOL)value;

// This method will process statistical data on the PushWizard server. It is necessary for making statistical information visible about your app.
// Info is an array with anything you want to send to the PushWizard server for further filtering.
+ (void)updateSessionWithValues:(NSArray *)values;

// This method will end the processing of statistical data on the PushWizard server. It is necessary for making statistical information visible about your app.
+ (void)endSession;

// Turn on GeoTagging with parameter set to YES. Call this function before the 'startWithToken'. This is turned off by default.
+ (void)doGeotagging:(BOOL)param;

@end
