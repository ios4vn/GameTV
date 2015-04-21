//
//  ServiceViewController.m
//  MusicNew
//
//  Created by Hai Trieu on 8/12/13.
//  Copyright (c) 2013 Adriaenssen BVBA. All rights reserved.
//

#import "ServiceViewController.h"
#import "SVPullToRefresh.h"
#import "LoginViewController.h"
#import "OLGhostAlertView.h"
#import "ServiceCell.h"
#import <MJPopupViewController/UIViewController+MJPopupViewController.h>
#import "ConfirmPayViewController.h"

@interface ServiceViewController () <ConfirmPaymentDelegate>

@end

@implementation ServiceViewController

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
    buttonRightBarType = BRightBarDone;
    
    [super viewDidLoad];
    lblTitle.text = @"GÓI DỊCH VỤ";
    self.tableView.showsPullToRefresh = NO;
    
    NSRange range = [lblTitleHeader.text rangeOfString:@"xxxx"];
    lblTitleHeader.text = [lblTitleHeader.text stringByReplacingOccurrencesOfString:@"xxxx" withString:SharedAppDelegate.user.username];
    NSMutableAttributedString* text = [[NSMutableAttributedString alloc]
                                       initWithAttributedString: lblTitleHeader.attributedText];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, [SharedAppDelegate.user.username length])];
    [lblTitleHeader setAttributedText:text];
    
    self.tableView.tableHeaderView = uvTableHeader;
    self.urlGetNews = [NSString stringWithFormat:@"act=getUserPackageInfor"];
    [self reloadNews];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    lblTitleHeader.text = @"Để sử dụng tốt nhất dịch vụ, quý khách vui lòng đăng ký một trong các gói cước sau:";
//    if (SharedAppDelegate.user.isLogin) {
//        if (!SharedAppDelegate.user.is3G || [SharedAppDelegate.user.email length] > 0) {
//            uvTableFooter.hidden = YES;
//        }
//        else{
//            uvTableFooter.hidden = NO;
//        }
//
//        displayname.text = SharedAppDelegate.user.username;
//        
//    }
//    else{
//        uvTableFooter.hidden = YES;
//    }
//    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)processResponse:(id)responseString{

    NSArray *tmpNews;
    tmpNews = [[responseString objectForKey:@"data"] objectForKey:@"availablePackage"];
    [self updateTableView:tmpNews];

}

#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifierHomeVideo = @"ServiceCell";
    ServiceCell *cell = (ServiceCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierHomeVideo];
    NSDictionary *service = [self.arrayNews objectAtIndex:indexPath.row];
    if (!cell) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ServiceCell" owner:nil options:nil];
        for (id obj in nibArray) {
            if ([obj isMemberOfClass:[ServiceCell class]]) {
                
                cell = (ServiceCell *)obj;
            }
        }
    }
    cell.title = [service objectForKey:@"title"];
    cell.msgGuide = [service objectForKey:@"defaultMessage"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *service = [self.arrayNews objectAtIndex:indexPath.row];
    BOOL isRegisted = [[service objectForKey:@"isRegisted"] boolValue];
    if (SharedAppDelegate.user.is3G) {

        ConfirmPayViewController *paymentViewController =[[ConfirmPayViewController alloc] initWithNibName:@"ConfirmPayViewController" bundle:nil];
        paymentViewController.delegate = self;
        paymentViewController.urlPayment = [service objectForKey:@"linkCharge"];
        if (isRegisted) {
            paymentViewController.isRegisted = YES;
        }
        [self presentPopupViewController:paymentViewController animationType:MJPopupViewAnimationFade dismissed:^{
            NSLog(@"dissmis");
            [self reloadNews];
        }];
    }
    else{
        
        NSString *msg = isRegisted ? [service objectForKey:@"declineMessageWifi"] : [service objectForKey:@"messageGuide"];
        [[[OLGhostAlertView alloc] initWithTitle:msg] show];
        
    }
}

-(void)dissmisForm{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(void)setIsLogin:(BOOL)isLogin{
    _isLogin = isLogin;

}

-(void)selectPackage:(id)sender{

}

-(IBAction)updateInfo:(id)sender{

}

-(void)registerPackage{
   
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == alChangePackage) {
        if (buttonIndex == 1) {
            [self registerPackage];
        }
    }
}
@end
