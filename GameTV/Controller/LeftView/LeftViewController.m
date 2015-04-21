//
//  SelectorController.m
//  TabbedExample
//
//  Created by Tom Adriaenssen on 03/02/12.
//  Copyright (c) 2012 Adriaenssen BVBA. All rights reserved.
//

#import "LeftViewController.h"
#import "IIViewDeckController.h"
#import "HomeViewController.h"
#import "MenuCell.h"
#import "HeaderMenu.h"
#import "InfoViewController.h"

@implementation LeftViewController

#pragma mark - Table view data source

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableHeaderView = _headerTableView;
    self.urlGetNews = @"sidebarcategory";
    _imgAvatar.layer.cornerRadius = 40;
    _imgAvatar.layer.masksToBounds = YES;
    [self reloadNews];
}

-(void)setupScrollView{

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (SharedAppDelegate.user.isLogin) {
        _lblInfo.text = [NSString stringWithFormat:@"ID:%d\nUser:%@",SharedAppDelegate.user.uid,SharedAppDelegate.user.username];
    }
    else{
        _lblInfo.text = @"Đăng nhập";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.arrayNews count];
    }

    return 2 + (SharedAppDelegate.user.isLogin ? 1 : 0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderMenu *header;
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"HeaderMenu" owner:nil options:nil];
    for (id xibObject in xibArray) {
        if ([xibObject isKindOfClass:[HeaderMenu class]]) {
            header = (HeaderMenu *)xibObject;
        }
    }

    if (section == 0) {
        header.sectionTitle = @"DANH MỤC";
    }
    else{
        header.sectionTitle = @"KHÁC";
    }
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    MenuCell *cell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:nil options:nil];
        for (id obj in nibArray) {
            if ([obj isMemberOfClass:[MenuCell class]]) {
                // Assign cell to obj
                cell = (MenuCell *)obj;
                break;
            }
        }
    }

    if (indexPath.section == 0) {
        NSDictionary *category = [self.arrayNews objectAtIndex:indexPath.row];
        cell.tittle = [category objectForKey:@"name"];
        cell.imageType = [category objectForKey:@"avatar"];
    }
    else{
        switch (indexPath.row) {
            case 0:
                cell.tittle = @"Ứng dụng liên quan";
                cell.imageType = @"sidebar_ungdung";
                break;
            case 1:
                cell.tittle = @"Thông tin liên hệ";
                cell.imageType = @"sidebar_info";
                break;
            case 2:
                cell.tittle = @"Thoát";
                cell.imageType = @"sidebar_danhgia";
                break;                
            default:
                break;
        }
    }

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        CategoryNews *category = [[CategoryNews alloc] init];
        NSDictionary *aCategory = [self.arrayNews objectAtIndex:indexPath.row];
        category.categoryId = [aCategory objectForKey:@"id"];
        category.categoryName = [aCategory objectForKey:@"name"];
        HomeViewController *homeVC = (HomeViewController*)[SharedAppDelegate.homeController topViewController];
        homeVC.category = category;
        [homeVC refreshContent];
        self.viewDeckController.centerController = SharedAppDelegate.homeController;
    }
    else{
        switch (indexPath.row) {
            case 1:
            {
                InfoViewController *infoVc = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
                [infoVc setUrlRequest:[NSString stringWithFormat:@"%@info",kDomain]];
                UINavigationController *navInfo = [[UINavigationController alloc] initWithRootViewController:infoVc];
                self.viewDeckController.centerController = navInfo;
            }
                break;
            case 2:
            {
                SharedAppDelegate.user = [[AppUser alloc] init];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:@"Username"];
                [defaults removeObjectForKey:@"Password"];
                [defaults synchronize];
                [self.tableView reloadData];
            }
                break;
            default:
                break;
        }
    }
    
    [self.viewDeckController toggleLeftView];
}

-(IBAction)btnLoginPress:(id)sender{

    if (SharedAppDelegate.user.isLogin) {
        [SharedAppDelegate showInfo];
    }
    else{
        [SharedAppDelegate showLogin];
    }
    
}
@end
