//
//  AppDelegate.m
//  GameTV
//
//  Created by Hai Trieu on 4/3/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ScheduleViewController.h"
#import "LiveViewController.h"
#import "LoginViewController.h"
#import "UserInfoViewController.h"
#import "iRate.h"
#import "iVersion.h"
#import "PushWizard.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#define ANIMATION_TIME 0.4
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

static NSString *kAppKey = @"568f2d61a3fc273b2e8b48e5";

@interface AppDelegate () <CustomTabbarDelegate>

@end

@implementation AppDelegate

@synthesize window = _window;


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    NSLog(@"open from others app %@",[url absoluteString]);
    if ([[url absoluteString] containsString:@"1"]){
        [self showSecondControllerWithVideoId:7789];
    }
    else {
        [self showSecondControllerWithVideoId:7785];
    }
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    
    /*Push wizard begin*/
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                             |UIUserNotificationTypeBadge
                                                                                             |UIUserNotificationTypeSound) categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert |
                                                                               UIRemoteNotificationTypeBadge |
                                                                               UIRemoteNotificationTypeSound)];
    }
    
    NSDictionary *payload = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (payload) {
        [self application:application didReceiveRemoteNotification:payload];
    }
    /*Push wizard end*/
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.leftViewController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    [iVersion sharedInstance].applicationBundleID = @"com.gametv.apps";
    self.homeController = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil]];
    
    _deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.homeController  leftViewController:self.leftViewController];
    _deckController.leftSize = self.window.frame.size.width - 260;
    _user = [[AppUser alloc] init];
    _deckController.panningMode =  IIViewDeckNavigationBarOrOpenCenterPanning;
    _deckController.centerhiddenInteractivity =  IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    self.window.rootViewController = _deckController;
    [self.window makeKeyAndVisible];
    
    [FBSDKAppLinkUtility fetchDeferredAppLink:^(NSURL *url, NSError *error) {
        if (error) {
            NSLog(@"Received error while fetching deferred app link %@", error);
        }
        if (url) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // You can send a custom NSArray with max 100 NSString values for later filtering
    [PushWizard startWithToken:deviceToken andAppKey:kAppKey andValues:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Necessary for handling special events, like URL Redirecting and Review Requests
    // Set processOnlyStatisticalData to YES if you want to handle the message on your own
    
    //comment it out if you use the old stable SDK
    [PushWizard handleNotification:userInfo processOnlyStatisticalData:NO];
    
    //this is for the old stable SDK
    //[PushWizard handleNotification:userInfo];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // You can send a custom NSArray with max 100 NSString values for later filtering
    application.applicationIconBadgeNumber = 0;
    [PushWizard updateSessionWithValues:nil];
    [FBSDKAppEvents activateApp];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [PushWizard endSession];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ditech.GameTV" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GameTV" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GameTV.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


-(void)initTabbar{
    
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"CustomTabbar" owner:nil options:nil];
    for (id xibObject in xibArray) {
        //Loop through array, check for the object we're interested in.
        if ([xibObject isKindOfClass:[CustomTabbar class]]) {
            _tabbar = (CustomTabbar *)xibObject;
        }
    }
    _tabbar.frame = CGRectMake(0, _window.frame.size.height - _tabbar.frame.size.height, _tabbar.frame.size.width, _tabbar.frame.size.height);
    _tabbar.delegate = self;
    [[self window] addSubview:_tabbar];
    
}

-(void)setShowTabbar:(BOOL)showTabbar{
    _showTabbar = showTabbar;
    if (showTabbar) {
        
        [self toggleTabbar:YES];
        
    }
    else{
        [self toggleTabbar:NO];
    }
    
}


-(void)toggleTabbar:(BOOL)show{
    if (show) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:ANIMATION_TIME animations:^{
                SharedAppDelegate.tabbar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -SharedAppDelegate.tabbar.frame.size.height, 0);
            }];
        });

    }
    else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:ANIMATION_TIME animations:^{
                SharedAppDelegate.tabbar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, SharedAppDelegate.tabbar.frame.size.height, 0);
            }];
        });
        
    }
}

- (void)tabBar:(CustomTabbar *)tabBar didSelectAtIndex:(NSInteger)index{
    switch (index) {
        case 1:
            _deckController.centerController = _homeController;
            break;
        case 0:
            if (_liveController == nil) {
                self.liveController = [[UINavigationController alloc] initWithRootViewController:[[LiveViewController alloc] initWithNibName:@"LiveViewController" bundle:nil]];
            }
            _deckController.centerController = _liveController;
            break;
        case 2:
            if (_scheduleController == nil) {
                self.scheduleController = [[UINavigationController alloc] initWithRootViewController:[[ScheduleViewController alloc] initWithNibName:@"ScheduleViewController" bundle:nil]];
            }
            _deckController.centerController = _scheduleController;
            break;
        default:
            _deckController.centerController = _homeController;
            break;
    }
}


#pragma mark -
#pragma mark -Important Methods

- (void)showSecondControllerWithVideoId:(double)videoId
{
    if (self.videoDetailViewController != nil) {
        [self removeController];
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
    
//    [[Utils shareInstance] showLoadingView];
    self.videoDetailViewController = [[BSVideoDetailController alloc] initWithNibName:@"BSVideoDetailController" bundle:nil];
    self.videoDetailViewController.videoId = videoId;
    [self.interstitial presentFromRootViewController:SharedAppDelegate.window.rootViewController];
//    [self showSecondController];
}

- (void)showSecondControllerWithChannel:(Channel*)channel{

    if (self.videoDetailViewController != nil) {
        [self removeController];
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
//    
//    [[Utils shareInstance] showLoadingView];
    self.videoDetailViewController = [[BSVideoDetailController alloc] initWithNibName:@"BSVideoDetailController" bundle:nil];
    self.videoDetailViewController.channel = channel;
    [self showSecondController];
    
}

-(void)showSecondController{
    
    self.videoDetailViewController.view.frame=CGRectMake(_window.frame.size.width - 50, _window.frame.size.height - 50, _window.frame.size.width, _window.frame.size.height);
    self.videoDetailViewController.initialFirstViewFrame= _window.frame;
    
    
    self.videoDetailViewController.view.alpha=0;
    self.videoDetailViewController.view.transform=CGAffineTransformMakeScale(0.2, 0.2);
    
    [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelStatusBar;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    [[UIApplication sharedApplication].keyWindow addSubview:self.videoDetailViewController.view];
    self.videoDetailViewController.onView = _window;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.videoDetailViewController.view.transform=CGAffineTransformMakeScale(1.0, 1.0);
        self.videoDetailViewController.view.alpha=1;
        
        self.videoDetailViewController.view.frame=CGRectMake(_window.frame.origin.x, _window.frame.origin.y, _window.frame.size.width, _window.frame.size.height);

    }];
}

- (void)removeController
{
//    int randNum = rand() % 4;
//    NSLog(@"rand num is %d",randNum);
    [self.videoDetailViewController removeView];
    self.videoDetailViewController=nil;
    
}

-(UINavigationController*)loginViewController{
    if (_loginViewController == nil) {
        _loginViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil]];
    }
    
    return _loginViewController;
}

-(void)showLogin{
    
    [self.window.rootViewController presentViewController:SharedAppDelegate.loginViewController animated:YES completion:^{
        [SharedAppDelegate.loginViewController popToRootViewControllerAnimated:YES];
    }];
    
}

-(void)showInfo{

    UINavigationController *navInfo = [[UINavigationController alloc] initWithRootViewController:[[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController" bundle:nil]];
    [self.window.rootViewController presentViewController:navInfo animated:YES completion:^{

    }];
    
}


#pragma mark Good Admob

- (void)initAdmobFull {
    self.interstitial = [self createAndLoadInterstitial];
}

- (void)showAdmobFull{
    [self.interstitial presentFromRootViewController:SharedAppDelegate.window.rootViewController];
}

- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:kAdmobFull];
    interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    [interstitial loadRequest:request];
    return interstitial;
}


#pragma mark GADInterstitialDelegate implementation

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
    [self showSecondController];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self.interstitial = [self createAndLoadInterstitial];
    [self showSecondController];
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    self.interstitial = ad;
}

@end
