//
//  ChangePasswordViewController.m
//  Music
//
//  Created by Huynv.tb on 6/1/13.
//  Copyright (c) 2013 Adriaenssen BVBA. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "OLGhostAlertView.h"
#import "AccountViewController.h"

@interface ChangePasswordViewController ()
-(BOOL)validateForm;
@end

@implementation ChangePasswordViewController
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
    self.headerTitle = @"Đổi mật khẩu";
    tableView.tableFooterView = footerView;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
   
    [super viewDidUnload];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return oldCell;
    }
    else if(indexPath.row == 1){
        return new1Cell;
    }
    else{
            return new2Cell;
        
    }
}
- (IBAction)btnOK:(id)sender {
    [_textField resignFirstResponder];
    if (![self validateForm]) {
        return;
    }

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"changepassword" forKey:@"act"];
    [params setObject:passOld.text forKey:@"current_pass"];
    [params setObject:passNew1.text forKey:@"new_pass"];
    [params setObject:passNew2.text forKey:@"re_new_pass"];
    [params setObject:SharedAppDelegate.user.token forKey:@"ssid"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:kDomainPost parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON reset password: %@", responseObject);
        [[[OLGhostAlertView alloc] initWithTitle:[responseObject objectForKey:@"mss"]] show];
        if ([[responseObject objectForKey:@"status"] intValue] == 200) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _textField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}

-(BOOL)validateForm{
    NSMutableString *errorMsg = [[NSMutableString alloc] init];
    if ([passNew1.text length] < 6) {
        [errorMsg appendFormat:@"Mật khẩu không hợp lệ\n"];
    }
    if ([passNew2.text length] < 6) {
        [errorMsg appendFormat:@"Mật khẩu không hợp lệ\n"];
    }
    if (![passNew1.text isEqualToString:passNew2.text]) {
        [errorMsg appendFormat:@"Mật khẩu không trùng nhau\n"];
    }
    if ([errorMsg length] > 0) {
        OLGhostAlertView *alertView = [[OLGhostAlertView alloc] initWithTitle:errorMsg];
        [alertView show];
        return NO;
    }
    return YES;
}
- (IBAction)btnCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
