//
//  SearchViewController.m
//  NhacDj
//
//  Created by Hai Trieu on 11/6/14.
//  Copyright (c) 2014 Hai Trieu. All rights reserved.
//

#import "SearchViewController.h"
#import "UITableView+NXEmptyView.h"
#import "BaseCell.h"
#import "SlideCell.h"
#import "VideoCell.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblTitle.text = @"Tìm kiếm";
    self.tableView.nxEV_hideSeparatorLinesWhenShowingEmptyView = YES;
    [self reloadNews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//0406945560
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row) {
        return 105;
    }
    
    //First row
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *cell;
    NSDictionary *video = [self.arrayNews objectAtIndex:indexPath.row];
    if (indexPath.row) {
        static NSString *CellIdentifier = @"VideoCell";
        cell = (VideoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"VideoCell" owner:nil options:nil];
            for (id obj in nibArray) {
                if ([obj isMemberOfClass:[VideoCell class]]) {
                    // Assign cell to obj
                    cell = (VideoCell *)obj;
                    break;
                }
            }
        }
        
    }
    else{
        static NSString *CellIdentifier = @"SlideCell";
        cell = (SlideCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"SlideCell" owner:nil options:nil];
            for (id obj in nibArray) {
                if ([obj isMemberOfClass:[SlideCell class]]) {
                    // Assign cell to obj
                    cell = (SlideCell *)obj;
                    break;
                }
            }
        }
        
    }
    
    cell.title = [video objectForKey:@"title"];
    cell.thumbnailUrl = [video objectForKey:@"avatar"];
    cell.dateCreated = [video objectForKey:@"date"];
    cell.viewCount = [video objectForKey:@"views"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *match = [self.arrayNews objectAtIndex:indexPath.row];
    [SharedAppDelegate showSecondControllerWithVideoId:[[match objectForKey:@"id"] doubleValue]];
    
}


@end
