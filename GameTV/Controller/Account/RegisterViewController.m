//
//  RegisterViewController.m
//  Sport
//
//  Created by Hai Trieu on 3/1/13.
//
//

#import "RegisterViewController.h"
#import "ValidViewController.h"
#import "OLGhostAlertView.h"

@interface RegisterViewController ()

-(BOOL)validateForm;

@end

@implementation RegisterViewController

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
    self.headerTitle = @"Đăng ký";
    [super viewDidLoad];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return usrCell;
            break;
        case 1:
            return disCell;
            break;
        case 2:
            return pwdCell;
            break;
        case 3:
            return repwdCell;
            break;
    }
    return nil;
}

-(IBAction)signupBtnPress:(id)sender{
    [_textField resignFirstResponder];
    if (![self validateForm]) {
        return;
    }
    
    [_textField resignFirstResponder];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"member_register" forKey:@"action"];
    [params setObject:displayname.text forKey:@"params_email"];
    [params setObject:password.text forKey:@"params_password"];
    [params setObject:username.text forKey:@"params_phone"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kLiveUrl parameters:[params addToken] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON register : %@", responseObject);
        [[[OLGhostAlertView alloc] initWithTitle:[responseObject objectForKey:@"mss"]] show];
        if ([[responseObject objectForKey:@"status"] intValue] == 200) {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark UITextFieldDelegate

-(IBAction)signinBtnPress:(id)sender{
    [_textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _textField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [self animateTextField:textField up:YES];
    [_textField resignFirstResponder];
    return YES;
}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField == email) {
//        [self animateTextField:textField up:NO];
//    }
//}



-(BOOL)validateForm{
    NSMutableString *errorMsg = [[NSMutableString alloc] init];
    if ([username.text length] < 9) {
        [errorMsg appendFormat:@"Số điện thoại không hợp lệ\n"];
    }
    if ([password.text length] < 6) {
        [errorMsg appendFormat:@"Mật khẩu không hợp lệ\n"];
    }
    if (![password.text isEqualToString:repassword.text]) {
        [errorMsg appendFormat:@"Mật khẩu không trùng nhau\n"];
    }
    if ([errorMsg length] > 0) {
        OLGhostAlertView *alertView = [[OLGhostAlertView alloc] initWithTitle:errorMsg];
        [alertView show];
        return NO;
    }
    return YES;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}



@end
