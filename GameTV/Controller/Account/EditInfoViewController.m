//
//  EditInfoViewController.m
//  uClip
//
//  Created by Hai Trieu on 1/29/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "EditInfoViewController.h"

@interface EditInfoViewController ()

-(void)setupTextDropDown;

@end

@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblTitle.text = @"CẬP NHẬT THÔNG TIN";
    [self setupTextDropDown];
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

-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}


-(void)setupTextDropDown{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    _txtBirthday.inputAccessoryView = toolbar;
    _txtBirthday.dropDownMode = IQDropDownModeDatePicker;
    _txtCMNDDate.inputAccessoryView = toolbar;
    _txtCMNDDate.dropDownMode = IQDropDownModeDatePicker;
    
}

-(IBAction)okPress:(id)sender{
    [self.view endEditing:YES];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"updateinfor" forKey:@"act"];
    [params setObject:_txtFullname.text forKey:@"fullname"];
    [params setObject:_txtBirthday.text forKey:@"birthday"];
    [params setObject:_txtCMND.text forKey:@"identification"];
    [params setObject:_txtCMNDDate.text forKey:@"identify_date"];
    [params setObject:_txtCMNDProvince.text forKey:@"identify_place"];
    [params setObject:_txtEmail.text forKey:@"email"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:kDomainPost parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON update : %@", responseObject);
        [[[OLGhostAlertView alloc] initWithTitle:[responseObject objectForKey:@"mss"]] show];
        if ([[responseObject objectForKey:@"status"] intValue] == 200) {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
