//
//  ResetPasswordViewController.m
//  Sport
//
//  Created by Hai Trieu on 6/13/13.
//
//

#import "ResetPasswordViewController.h"
#import "OLGhostAlertView.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

UITextField *_textField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPhone:(NSString*)phonenumber
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _phonenumber = phonenumber;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    lblTitle.text = @"Cài lại mật khẩu";
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

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _textField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}
//resetpass
-(IBAction)resetBtnPress:(id)sender{
    [_textField resignFirstResponder];
    if (![self validateForm]) {
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"confirmnewpass" forKey:@"act"];
    [params setObject:validCode.text forKey:@"confirm_key"];
    [params setObject:password.text forKey:@"newpassword"];
    [params setObject:repassword.text forKey:@"renewpassword"];
    [params setObject:_phonenumber forKey:@"phone"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:kDomainPost parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON reset password: %@", responseObject);
        [[[OLGhostAlertView alloc] initWithTitle:[responseObject objectForKey:@"mss"]] show];
        if ([[responseObject objectForKey:@"status"] intValue] == 200) {

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
//forgot pass
-(IBAction)resendBtnPress:(id)sender{

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return validCell;
    }
    else if(indexPath.row == 1){
        return pwdCell;
    }
    else{
        return repwdCell;
    }
}

-(BOOL)validateForm{
    NSMutableString *errorMsg = [[NSMutableString alloc] init];
    if ([validCode.text length] < 2) {
        [errorMsg appendFormat:@"Mã xác thực không hợp lệ\n"];
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

@end
