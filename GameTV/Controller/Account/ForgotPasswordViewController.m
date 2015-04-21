//
//  ForgotPasswordViewController.m
//  Sport
//
//  Created by Hai Trieu on 6/13/13.
//
//

#import "ForgotPasswordViewController.h"
#import "OLGhostAlertView.h"
#import "ResetPasswordViewController.h"

@interface ForgotPasswordViewController ()
-(BOOL)validateForm;
@end

@implementation ForgotPasswordViewController

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

    self.headerTitle = @"Quên mật khẩu";
    tableView.tableHeaderView = headerView;
    tableView.tableFooterView = footerView;
    
    UIColor *backGroundColor = [[UIColor alloc]initWithRed:1.0 green:1.0 blue:1.0  alpha:0.1];
    UIView *bview = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
    [bview setBackgroundColor:backGroundColor];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setBackgroundView:bview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//forgotpass
-(IBAction)forgotBtnPress:(id)sender{
    if (![self validateForm]) {
        return;
    }
    [phoneTxt resignFirstResponder];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"sendconfirmkey" forKey:@"act"];
    [params setObject:phoneTxt.text forKey:@"phone"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:kDomainPost parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON register : %@", responseObject);
        [[[OLGhostAlertView alloc] initWithTitle:[responseObject objectForKey:@"mss"]] show];
        if ([[responseObject objectForKey:@"status"] intValue] == 200) {
            ResetPasswordViewController *resetView = [[ResetPasswordViewController alloc] initWithNibName:@"ResetPasswordViewController" bundle:nil andPhone:phoneTxt.text];
            [self.navigationController pushViewController:resetView animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
}

-(IBAction)loginBtnPress:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

-(BOOL)validateForm{
    if ([phoneTxt.text length] <1) {
        OLGhostAlertView *alertView = [[OLGhostAlertView alloc] initWithTitle:@"Bạn chưa nhập số điện thoại/email"];
        [alertView show];
        return NO;
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return phoneCell;
}
@end
