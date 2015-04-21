//
//  ForgotPasswordViewController.h
//  Sport
//
//  Created by Hai Trieu on 6/13/13.
//
//

#import <UIKit/UIKit.h>
#import "StandarUserViewController.h"

@interface ForgotPasswordViewController : StandarUserViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITextField *phoneTxt;
    IBOutlet UITableView *tableView;
    IBOutlet UIView *footerView;
    IBOutlet UIView *headerView;
    IBOutlet UITableViewCell *phoneCell;
}

-(IBAction)forgotBtnPress:(id)sender;
-(IBAction)loginBtnPress:(id)sender;
@end
