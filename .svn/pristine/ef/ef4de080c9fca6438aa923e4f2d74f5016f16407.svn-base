//
//  ApplicationsViewController.m
//  NhacDj
//
//  Created by Hai Trieu on 9/24/14.
//  Copyright (c) 2014 Hai Trieu. All rights reserved.
//

#import "ApplicationsViewController.h"
#import "ApplicationDetailViewController.h"
#import "ApplicationCell.h"

@interface ApplicationsViewController ()

@end

@implementation ApplicationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblTitle.text = @"Ứng dụng liên quan";
    self.keyArrayData = @"articleCatData";
    self.urlGetNews = @"act=listArticleCat&type=news&cat=4";
    [self reloadNews];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* item = [self.arrayNews objectAtIndex:indexPath.row];
    static NSString *CellIdentifierHome = @"ApplicationCell";
    ApplicationCell *cell = (ApplicationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierHome];
    
    if (!cell) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ApplicationCell" owner:nil options:nil];
        for (id obj in nibArray) {
            if ([obj isMemberOfClass:[ApplicationCell class]]) {
                
                cell = (ApplicationCell *)obj;
                [cell.imgThumbnail.layer setCornerRadius:5.0];
                [cell.imgThumbnail.layer setMasksToBounds:YES];
                
            }
        }
    }
    
    cell.title = [item objectForKey:@"title"];
    cell.thumbnailUrl = [item objectForKey:@"thumb"];
    cell.lblDescription.text = [item objectForKey:@"description"];
    cell.appId = [[item objectForKey:@"id"] intValue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *application = [self.arrayNews objectAtIndex:indexPath.row];
    ApplicationDetailViewController *detailView = [[ApplicationDetailViewController alloc] initWithNibName:@"ApplicationDetailViewController" bundle:nil];
    detailView.appInfo = application;
    [self.navigationController pushViewController:detailView animated:YES];
}
@end
