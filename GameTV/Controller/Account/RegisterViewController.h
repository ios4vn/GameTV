//
//  RegisterViewController.h
//  Sport
//
//  Created by Hai Trieu on 3/1/13.
//
//

#import <UIKit/UIKit.h>
#import "StandarUserViewController.h"

@interface RegisterViewController : StandarUserViewController{
    
    IBOutlet UITableView *tableView;
    IBOutlet UIView *footerView;
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextField *displayname;
    IBOutlet UITextField *repassword;
    IBOutlet UITableViewCell *usrCell;
    IBOutlet UITableViewCell *disCell;
    IBOutlet UITableViewCell *pwdCell;
    IBOutlet UITableViewCell *repwdCell;
    
}

-(IBAction)signupBtnPress:(id)sender;
-(IBAction)signinBtnPress:(id)sender;

@end
