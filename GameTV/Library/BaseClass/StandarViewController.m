//
//  StandarViewController.m
//  uClip
//
//  Created by Hai Trieu on 1/2/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "StandarViewController.h"
#import "AutoCompleteViewController.h"
#import "SearchViewController.h"
#import "IIViewDeckController.h"
#import "NSString+MD5.h"

@interface StandarViewController () <AutoCompleteViewControllerDelegate>

@property (nonatomic, strong) AutoCompleteViewController *autoCompleteView;

@end

@implementation StandarViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupTilte];
    [self setupSearchBar];
    [self setupNavigationBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can bl;le recreated.
}

-(void)setupNavigationBar{    
    UIImage *backgroundImage = [UIImage imageNamed:@"header_ios.png"];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];

    
    if ([self.navigationController.viewControllers count] > 1) {
        UIImage* backImg = [UIImage imageNamed:@"btn_back.png"];
        CGRect frameBackImg = CGRectMake(0, 0, backImg.size.width, backImg.size.height);
        UIButton *backBtn = [[UIButton alloc] initWithFrame:frameBackImg];
        [backBtn setBackgroundImage:backImg forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back)
          forControlEvents:UIControlEventTouchUpInside];
        [backBtn setShowsTouchWhenHighlighted:YES];
        UIBarButtonItem *backPage =[[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backPage;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    }
    else{
        
        UIImage* menuImg = [UIImage imageNamed:@"btn_menu.png"];
        CGRect frameMenuImg = CGRectMake(0, 0, menuImg.size.width, menuImg.size.height);
        UIButton *menuBtn = [[UIButton alloc] initWithFrame:frameMenuImg];
        [menuBtn setBackgroundImage:menuImg forState:UIControlStateNormal];
        [menuBtn addTarget:self.viewDeckController action:@selector(toggleLeftView)
          forControlEvents:UIControlEventTouchUpInside];
        [menuBtn setShowsTouchWhenHighlighted:YES];
        UIBarButtonItem *menuPage =[[UIBarButtonItem alloc] initWithCustomView:menuBtn];
        self.navigationItem.leftBarButtonItem = menuPage;
    }

    switch (buttonRightBarType) {
        case BRightBarDone:
        {
            UIImage* imageDone = [UIImage imageNamed:@"login_close"];
            CGRect frameimgDone = CGRectMake(0, 8, imageDone.size.width, imageDone.size.height);
            UIButton *topButton = [[UIButton alloc] initWithFrame:frameimgDone];
            [topButton setBackgroundImage:imageDone forState:UIControlStateNormal];
            [topButton setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
            [topButton addTarget:self action:@selector(closeLoginPress)
                forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *done =[[UIBarButtonItem alloc] initWithCustomView:topButton];
            self.navigationItem.rightBarButtonItem = done;
        }
            break;
            
        default:
        {
            UIImage* searchImg = [UIImage imageNamed:@"btn_search"];
            CGRect frameSearchImg = CGRectMake(40, 13, searchImg.size.width, searchImg.size.height);
            UIButton *searchBtn = [[UIButton alloc] initWithFrame:frameSearchImg];
            [searchBtn setBackgroundImage:searchImg forState:UIControlStateNormal];
            [searchBtn addTarget:self action:@selector(searchBarBtnPress)
                forControlEvents:UIControlEventTouchUpInside];
            [searchBtn setShowsTouchWhenHighlighted:YES];
            
            UIImage* imageDict = [UIImage imageNamed:@"header_icon_dic"];
            CGRect frameimgDict = CGRectMake(0, 15, imageDict.size.width*0.7, imageDict.size.height*0.7);
            UIButton *dictBtn = [[UIButton alloc] initWithFrame:frameimgDict];
            [dictBtn setBackgroundImage:imageDict forState:UIControlStateNormal];
            dictBtn.frame = CGRectInset(dictBtn.frame, -5, -5);
            [dictBtn setShowsTouchWhenHighlighted:YES];
            
            UIView *leftItems = [[UIView alloc] initWithFrame:CGRectMake(0,0, 60,44)];
            [leftItems addSubview:dictBtn];
            [leftItems addSubview:searchBtn];
            
            UIBarButtonItem *customBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftItems];
            self.navigationItem.rightBarButtonItem = customBarButton;
            
        }
            break;
    }


}

-(void)setHeaderTitle:(NSString *)headerTitle{
    _headerTitle = headerTitle;
    lblTitle.text = headerTitle;
}

-(void)setupTilte{
    
    lblTitle = [[MarqueeLabel alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.marqueeType = MLLeftRight;
    lblTitle.font = [UIFont fontWithName:@"Roboto-Bold" size:18.0];
    lblTitle.adjustsFontSizeToFitWidth = YES;
    lblTitle.text = @"English";
    self.navigationItem.titleView = lblTitle;
    lblTitle.text = self.headerTitle;
    
}

-(void)doLoginWithUsername:(NSString*)username andPassword:(NSString*)password complete:(void(^)(id responseObject))completionBlock fail:(void(^)(id responseObject))failBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    if ([username NSStringIsValidEmail]) {
        [parameters setObject:username forKey:@"params_email"];
    }
    else{
        [parameters setObject:username forKey:@"params_phone"];
    }
    [parameters setObject:password forKey:@"params_password"];
    [parameters setObject:@"member_login" forKey:@"action"];
    [[Utils shareInstance] showLoadingView];
    [manager GET:kLiveUrl parameters:[parameters addToken] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[Utils shareInstance] hideLoadingView];
        if ([[responseObject objectForKey:@"status"] intValue] == 0) {
            NSDictionary *user = [responseObject objectForKey:@"data"];
            NSLog(@"user info is %@",user);
            SharedAppDelegate.user.uid = [[user objectForKey:@"id"] intValue];
            SharedAppDelegate.user.ipAddress = [user objectForKey:@"ip_address"];
            SharedAppDelegate.user.isLogin = YES;
            SharedAppDelegate.user.email = [user objectForKey:@"email"];
            SharedAppDelegate.user.username = [user objectForKey:@"telephone"];
            SharedAppDelegate.user.fCoin = [[user objectForKey:@"fcoin"] intValue];
            SharedAppDelegate.user.password = password;
            SharedAppDelegate.user.token = [user objectForKey:@"member_key"];
            SharedAppDelegate.user.joinDate = [NSDate dateWithTimeIntervalSince1970:[[user objectForKey:@"join_date"] intValue]];
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            [standardUserDefaults setObject:SharedAppDelegate.user.username forKey:@"UserName"];
            [standardUserDefaults setObject:SharedAppDelegate.user.password forKey:@"Password"];
            [standardUserDefaults setObject:SharedAppDelegate.user.displayname forKey:@"PhoneNumber"];
            
            [standardUserDefaults synchronize];
            if (completionBlock) {
                completionBlock(responseObject);
            }
        }
        else{
            [[[OLGhostAlertView alloc] initWithTitle:[responseObject objectForKey:@"mss"]] show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failBlock) {
            [[Utils shareInstance] hideLoadingView];
            failBlock(error);
        }
    }];
}



-(void)closeLoginPress{
    if (SharedAppDelegate.window.rootViewController.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        if ([self.navigationController.viewControllers count] == 1) {

        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


-(void)searchBarBtnPress{
    if ([self.searchBar superview]) {
        [self hideWithAnimated:self.searchBar withAnimated:0.1];
        [self.searchBar resignFirstResponder];
        [self.hideSearchBar removeFromSuperview];
        self.searchBar.text=@"";
    }
    else{
        [self showWithAnimated:self.searchBar withAnimated:0.1];
        [self.searchBar becomeFirstResponder];
        self.searchBar.showsCancelButton = YES;
        [self.view addSubview:self.hideSearchBar];
    }
}

#pragma mark UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    if (_hideSearchBar == nil) {
        
        self.hideSearchBar = [[UIButton alloc] initWithFrame:self.navigationController.view.frame];
        self.hideSearchBar.backgroundColor = [UIColor blackColor];
        self.hideSearchBar.alpha = 0.3;
        [self.hideSearchBar addTarget:self action:@selector(hideSearchBarClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self.view addSubview:_hideSearchBar];
    
    if (_autoCompleteView == nil) {
        self.autoCompleteView = [[AutoCompleteViewController alloc] initWithNibName:@"AutoCompleteViewController" bundle:nil];
        self.autoCompleteView.delegate = self;
        self.autoCompleteView.parentNavigationController = self.navigationController;
        if (kOsVersion < 7.0) {
            self.autoCompleteView.view.frame = CGRectMake(0, 44, self.view.frame.size.width, 160);
        }
        else{
            self.autoCompleteView.view.frame = CGRectMake(0, 64, self.view.frame.size.width, 160);
        }
    }
    
    if ([searchBar.text length] > 0) {
        [self.navigationController.view addSubview:_autoCompleteView.view];
        [_autoCompleteView setKeyword:searchBar.text];
    }
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (([searchText length] > 0) && [_autoCompleteView.view superview] == nil) {
        [self.navigationController.view addSubview:_autoCompleteView.view];
    }
    if ([searchText length] == 0) {
        [_autoCompleteView.view removeFromSuperview];
    }
    else{
        [_autoCompleteView setKeyword:searchText];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    
    [self.searchBar resignFirstResponder];
    [self hideWithAnimated:self.searchBar withAnimated:0.1];
    [self.hideSearchBar removeFromSuperview];
    [_autoCompleteView.view removeFromSuperview];
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchBar resignFirstResponder];
    [self hideWithAnimated:self.searchBar withAnimated:0.1];
    [self.hideSearchBar removeFromSuperview];
    [self.autoCompleteView.view removeFromSuperview];
    
    SearchViewController *searchView = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    searchView.urlGetNews = _autoCompleteView.urlGetNews;
    [self.navigationController pushViewController:searchView animated:YES];
    
}

-(void)showWithAnimated:(UIView*)showView{
    
    UIWindow *window = [SharedAppDelegate window];
    float navHeight = 0;
    UIView *parentView;
    if (window.rootViewController.presentedViewController) {
        parentView = window.rootViewController.presentedViewController.view;
    } else {
        parentView = window.rootViewController.view;
        navHeight = 44;
    }
    
    showView.frame = CGRectMake(0, parentView.frame.size.height, showView.frame.size.width, showView.frame.size.height);
    CGRect tmpRect = showView.frame;
    
    tmpRect.origin.y = parentView.frame.size.height - showView.frame.size.height - navHeight;
    [self.view addSubview:showView];
    
    [self.view bringSubviewToFront:showView ];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    showView.frame = tmpRect;
    
    [UIView commitAnimations];
}

-(void)hideWithAnimated:(UIView*)hideView{
    
    CGRect tmpRect = hideView.frame;
    tmpRect.origin.y = self.view.bounds.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:hideView];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    
    hideView.frame = tmpRect;
    [UIView commitAnimations];
    
}


-(void)hideSearchBarClicked{
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    [self hideWithAnimated:self.searchBar withAnimated:0.1];
    [self.hideSearchBar removeFromSuperview];
    [_autoCompleteView.view removeFromSuperview];
}

#pragma mark
-(void)didSelectRow:(AutoCompleteViewController *)viewController{
    
    [self hideSearchBarClicked];
    
}

-(void)setupSearchBar{
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.searchBar.showsCancelButton = YES;
    //    self.searchBar.tintColor = [UIColor colorWithRed:222/255.0 green:96/255.0 blue:40/255.0 alpha:1.0];
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.delegate = self;
    [self.searchBar setTranslucent:YES];
    
}


-(void)showWithAnimated:(UIView*)showView withAnimated:(float)duration{
    
    showView.frame = CGRectMake(0,-self.navigationController.navigationBar.frame.size.height, showView.frame.size.width, showView.frame.size.height);
    CGRect tmpRect = showView.frame;
    
    if (kOsVersion < 7.0) {
        tmpRect.origin.y = 0;
    }
    else{
        tmpRect.origin.y = 20;
    }
    
    [self.navigationController.view addSubview:showView];
    
    [self.navigationController.view bringSubviewToFront:showView ];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    showView.frame = tmpRect;
    
    [UIView commitAnimations];
}

-(void)hideWithAnimated:(UIView*)hideView withAnimated:(float)duration{
    CGRect tmpRect = hideView.frame;
    tmpRect.origin.y = -self.navigationController.navigationBar.frame.size.height;
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:hideView];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    
    hideView.frame = tmpRect;
    [UIView commitAnimations];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
