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
    
    //NSString* urlstr=[NSString stringWithFormat:@"%@%@",([[category objectForKey:@"avatar"] rangeOfString:@"http://"].length==0)?SharedAppDelegate.LinkServer:@"",[category objectForKey:@"avatar"]];
    NSString* urlstr=[video objectForKey:@"avatar"];
    [cell.imgThumbnail setImageWithURL:[NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"no_image"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];


//    
//    
//    cell.lblName.frame=CGRectMake(cell.lblName.frame.origin.x, cell.lblName.frame.origin.y, cell.lblName.frame.size.width, cell.lblName.frame.size.height);
//    cell.lblName.numberOfLines=0;
    cell.lblName.text=[video objectForKey:@"title"];
//    [cell.lblName sizeToFit];
//    
//    cell.lblTime.frame=CGRectMake(cell.lblTime.frame.origin.x, cell.lblName.frame.origin.y+cell.lblName.frame.size.height, cell.lblTime.frame.size.width, cell.lblTime.frame.size.height);
//    cell.imgTime.frame=CGRectMake(85*(self.view.frame.size.width/320), cell.lblName.frame.origin.y+cell.lblName.frame.size.height, cell.imgTime.frame.size.width, cell.imgTime.frame.size.height);
    cell.lblTime.text = [video objectForKey:@"time"];
//    float socao1=cell.lblTime.frame.origin.y;
//    float socao2=cell.lblTime.frame.size.height;
//    float socao=socao1+socao2+5*(self.view.frame.size.height/480);
//    if (socao<70) {
//        cell.imgThumbnail.frame=CGRectMake(0,0,socao,socao);
//    }
//    cell.imgBien.frame=CGRectMake(0, socao-1, cell.imgBien.frame.size.width, 1);
//    socaostrGoc=[NSString stringWithFormat:@"%f",socao];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
