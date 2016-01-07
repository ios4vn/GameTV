//
//  ViewInfoViewController.m
//  uClip
//
//  Created by Hai Trieu on 1/29/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "ViewInfoViewController.h"
#import "EditInfoViewController.h"
#import "AppUser.h"

@interface ViewInfoViewController ()

@end

@implementation ViewInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblTitle.text = @"THÔNG TIN CÁ NHÂN";
    AppUser *user = SharedAppDelegate.user;
    _lblInfo.text = [NSString stringWithFormat:@"Số điện thoại: %@\n\n"
                     @"Họ và tên: %@\n\n"
                     @"Email: %@",user.username,user.displayname,user.email];
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

-(IBAction)okPress:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)editPress:(id)sender{
    
    EditInfoViewController *editView = [[EditInfoViewController alloc] initWithNibName:@"EditInfoViewController" bundle:nil];
    [self.navigationController pushViewController:editView animated:YES];
    
}
@end
