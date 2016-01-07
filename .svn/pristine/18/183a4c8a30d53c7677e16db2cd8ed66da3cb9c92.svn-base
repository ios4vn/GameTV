//
//  InfoViewController.m
//  uClip
//
//  Created by Hai Trieu on 1/29/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@property (nonatomic, weak) IBOutlet UIWebView *wvContent;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblTitle.text = @"Thông tin";
    [_wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlRequest]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
