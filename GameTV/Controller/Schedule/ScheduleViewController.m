//
//  ScheduleViewController.m
//  GameTV
//
//  Created by Hai Trieu on 4/7/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "ScheduleViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblTitle.text = @"Lịch chiếu";
    self.urlGetNews = @"schedule";
    [self reloadNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self.arrayNews count]>indexPath.row) {
//        float docaoCell = [socaostrGoc floatValue];
//        return docaoCell;
//    }
//    
//    //First row
//    return 160;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScheduleCell *cell;
    NSDictionary *video = [self.arrayNews objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"ScheduleCell";
    cell = (ScheduleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil];
        for (id obj in nibArray) {
            if ([obj isMemberOfClass:[ScheduleCell class]]) {
                cell = (ScheduleCell *)obj;
                break;
            }
        }
    }
    
    NSDictionary *homeTeam = [video objectForKey:@"home"];
    [cell.imgHomeThumbnail setImageWithURL:[NSURL URLWithString:[[homeTeam objectForKey:@"avatar"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"no_image"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    cell.lblHomeName.text = [homeTeam objectForKey:@"name"];
    
    NSDictionary *awayTeam = [video objectForKey:@"away"];
    [cell.imgAwayThumbnail setImageWithURL:[NSURL URLWithString:[[awayTeam objectForKey:@"avatar"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"no_image"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    cell.lblAwayName.text = [awayTeam objectForKey:@"name"];
    
    cell.lblTime.text = [video objectForKey:@"time"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
