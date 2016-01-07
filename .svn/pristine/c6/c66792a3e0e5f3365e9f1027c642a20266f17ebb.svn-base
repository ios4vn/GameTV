//
//  StandarUserViewController.m
//  Topring
//
//  Created by Hai Trieu on 11/20/13.
//  Copyright (c) 2013 Ditech Corporation. All rights reserved.
//

#import "StandarUserViewController.h"

@interface StandarUserViewController ()

@end

@implementation StandarUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
//    buttonRightBarType = BRightBarDone;
    
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;
    UIImageView *logoHome;
    
    logoHome = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 42)];
    
    
    logoHome.image = [UIImage imageNamed:@"icon_game_header"];
    self.navigationItem.titleView = logoHome;
    
    if ([self.navigationController.viewControllers count] < 2) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    else{
        UIImage* backImg = [UIImage imageNamed:@"btn_back"];
        CGRect frameBackImg = CGRectMake(0, 0, backImg.size.width, backImg.size.height);
        UIButton *backBtn = [[UIButton alloc] initWithFrame:frameBackImg];
        [backBtn setBackgroundImage:backImg forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back)
          forControlEvents:UIControlEventTouchUpInside];
        [backBtn setShowsTouchWhenHighlighted:YES];
        UIBarButtonItem *backPage =[[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backPage;
    }

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
