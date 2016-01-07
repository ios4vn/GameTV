//
//  AccountViewController.m
//  Sport
//
//  Created by Hai Trieu on 3/15/13.
//
//

#import "AccountViewController.h"
#import "OLGhostAlertView.h"
#import "ChangePasswordViewController.h"
#import "SVPullToRefresh.h"
#import "ServiceViewController.h"
#import "AppUser.h"
#import "UserInfoViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

UITextField *_textField;

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

    [super viewDidLoad];
    self.headerTitle = @"Tài khoản cá nhân";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)userInfo:(id)sender{
    
    UserInfoViewController *userInfoView = [[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController" bundle:nil];
    [self.navigationController pushViewController:userInfoView animated:YES];
    
}

-(IBAction)changePassword:(id)sender{

    ChangePasswordViewController *changePasswordViewController = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:changePasswordViewController animated:YES];
}

-(IBAction)logout:(id)sender{
    SharedAppDelegate.user = [[AppUser alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"UserName"];
    [defaults removeObjectForKey:@"PassWord"];
    [defaults removeObjectForKey:@"DisplayName"];
    [defaults synchronize];
    SharedAppDelegate.user = [[AppUser alloc] init];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"UserChange" object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)serviceInfo:(id)sender{
    ServiceViewController *serviceView = [[ServiceViewController alloc] initWithNibName:@"ServiceViewController" bundle:nil];
    [self.navigationController pushViewController:serviceView animated:YES];
}
@end
