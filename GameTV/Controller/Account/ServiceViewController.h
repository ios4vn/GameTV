//
//  ServiceViewController.h
//  MusicNew
//
//  Created by Hai Trieu on 8/12/13.
//  Copyright (c) 2013 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTListViewController.h"

@interface ServiceViewController : HTListViewController {
    IBOutlet UILabel *lblTitleHeader;
    IBOutlet UIView *uvTableHeader;
    IBOutlet UIView *uvTableFooter;
    
    IBOutlet UITextField *password;
    IBOutlet UITextField *displayname;
    IBOutlet UITextField *repassword;
    IBOutlet UITextField *email;
    
    BOOL textFieldShow;

    UIAlertView *alChangePackage;
    NSString *msgAlertPackage;
    NSDictionary *usedPackage;
    NSDictionary *willRegisterPackage;
    
}

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isService;

-(IBAction)updateInfo:(id)sender;
-(void)registerPackage;

@end
