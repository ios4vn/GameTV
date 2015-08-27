//
//  LoginViewController.h
//  Sport
//
//  Created by Hai Trieu on 3/18/13.
//
//

#import <UIKit/UIKit.h>
#import "StandarUserViewController.h"

@interface LoginViewController : StandarUserViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {

    IBOutlet UITableViewCell *usrCell;
    IBOutlet UITableViewCell *pwdCell;
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITableView *tableView;
    IBOutlet UIView *footerView;
    IBOutlet UIView *headerView;
    
    IBOutlet UIButton *rememberPassword;
    BOOL isRememberPassword;
    
}

-(IBAction)signinBtnPress:(id)sender;
-(IBAction)singupBtnPress:(id)sender;
-(IBAction)forgotBtnPress:(id)sender;
-(IBAction)rememberPassPress:(id)sender;
-(BOOL)validateForm;
-(void)showSignUpForm;

-(IBAction)enterNoLogin:(id)sender;

@end
