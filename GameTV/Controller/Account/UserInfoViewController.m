//
//  UserInfoViewController.m
//  NhacDj
//
//  Created by Hai Trieu on 11/7/14.
//  Copyright (c) 2014 Hai Trieu. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ChangePasswordViewController.h"
#import <MJPopupViewController/UIViewController+MJPopupViewController.h>

@interface UserInfoViewController ()

-(void)setupToolBar;

@end

@implementation UserInfoViewController

UITextField *_textField;

- (void)viewDidLoad
{
    buttonRightBarType = BRightBarDone;
    [super viewDidLoad];
    tableView.hidden = YES;
    lblTitle.text = @"Thông tin cá nhân";
    tableView.layer.cornerRadius = 3.0;
    tableView.layer.masksToBounds = YES;
    username.text = SharedAppDelegate.user.username;
    username.enabled = NO;
    self.navigationItem.leftBarButtonItem = nil;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];

    NSString *htmlContain = [NSString stringWithFormat:
                             @"<b><font color=\"#fff\">ID: </font><font color=\"#47a842\">%d</font><br/>"
                             @"<font color=\"#fff\">Số Điện Thoai: </font><font color=\"#47a842\">%@</font><br/>"
                             @"<font color=\"#fff\">Email:  </font><font color=\"#47a842\">%@</font><br/>"
                             @"<font color=\"#fff\">Ngày tham gia: </font><font color=\"#47a842\">%@</font><br/>"
                             @"<font color=\"#F40035\">Fcoin:  </font><font color=\"#DBFF0A\">%d</font><br/></b>"
                             ,SharedAppDelegate.user.uid,SharedAppDelegate.user.username,SharedAppDelegate.user.email,[dateFormat stringFromDate:SharedAppDelegate.user.joinDate],SharedAppDelegate.user.fCoin];
    
    [wvUserInfo loadHTMLString:htmlContain baseURL:nil];

    [self setupToolBar];
}

-(void)setupToolBar{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    
    birthday.inputAccessoryView = toolbar;
    [birthday setDropDownMode:IQDropDownModeDatePicker];
    
}

-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
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
            return phoneCell;
            break;
        case 3:
            return bodCell;
            break;
    }
    return nil;
}

-(IBAction)signupBtnPress:(id)sender{
//
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:birthday.date];
//
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:@"register" forKey:@"act"];
//    [params setObject:username.text forKey:@"username"];
//    [params setObject:txtPhone.text forKey:@"phone"];
//    [params setObject:[NSString stringWithFormat:@"%d",day] forKey:@"day"];
//    [params setObject:[NSString stringWithFormat:@"%d",month] forKey:@"month"];
//    [params setObject:[NSString stringWithFormat:@"%d",year] forKey:@"day"];
//    [params setObject:@"1" forKey:@"gender"];
//    
//    ASIHTTPRequest *_requestNews = [[ASIHTTPRequest alloc] initWithParams:params];
//    __weak ASIHTTPRequest *requestNews = _requestNews;
//    [requestNews setCompletionBlock:^{
//        SBJson4Parser *jsonParser = [SBJson4Parser parserWithBlock:^(id item, BOOL *stop) {
//            
//            NSLog(@"item register is %@",item);
//            [[[OLGhostAlertView alloc] initWithTitle:[item objectForKey:@"msg"]] show];
//            if ([[item objectForKey:@"error"] intValue] == 0) {
////                [self doLoginWithUsername:username.text andPassword:password.text];
//                self.mSportDelegate = self;
//            }
//            
//        } allowMultiRoot:YES unwrapRootArray:NO errorHandler:^(NSError *error) {
//            
//        }];
//        
//        [jsonParser parse:[[requestNews responseString] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//    }];
//    
//    [requestNews startAsynchronous];
}

- (void)mSportDidLoginWithUsername:(NSString*)username andPassword:(NSString*)password{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark UITextFieldDelegate

-(IBAction)signinBtnPress:(id)sender{
  
    [_textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];

}

-(IBAction)changePassBtnPress:(id)sender{
    
    ChangePasswordViewController *changePassView = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:changePassView animated:YES];
    
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
    //    if ([email.text length] > 0 && ![self NSStringIsValidEmail:email.text]) {
    //        [errorMsg appendFormat:@"Email không hợp lệ"];
    //    }
    if ([errorMsg length] > 0) {
        OLGhostAlertView *alertView = [[OLGhostAlertView alloc] initWithTitle:errorMsg];
        [alertView show];
        return NO;
    }
    return YES;
}

-(void)setupUpdateForm{
    username.text = SharedAppDelegate.user.username;
    username.enabled = NO;
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

-(IBAction)activeBtnPress:(id)sender{

    
}

-(IBAction)logoutPress:(id)sender{
 
}

@end