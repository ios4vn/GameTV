//
//  ResetPasswordViewController.h
//  Sport
//
//  Created by Hai Trieu on 6/13/13.
//
//

#import <UIKit/UIKit.h>
#import "StandarUserViewController.h"

@interface ResetPasswordViewController : StandarUserViewController {
    IBOutlet UITableView *tableView;
    IBOutlet UIView *footerView;
    IBOutlet UITextField *validCode;
    IBOutlet UITextField *password;
    IBOutlet UITextField *repassword;
    IBOutlet UITableViewCell *validCell;
    IBOutlet UITableViewCell *pwdCell;
    IBOutlet UITableViewCell *repwdCell;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPhone:(NSString*)phonenumber;

@property (nonatomic, strong) NSString *phonenumber;

-(IBAction)resetBtnPress:(id)sender;
-(IBAction)resendBtnPress:(id)sender;

@end
