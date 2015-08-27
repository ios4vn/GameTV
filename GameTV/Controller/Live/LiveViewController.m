//
//  LiveViewController.m
//  GameTV
//
//  Created by Hai Trieu on 4/7/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "LiveViewController.h"
#import "NSMutableDictionary+UrlRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "BaseCell.h"
#import "VideoCell.h"
#import <UIAlertView+Blocks/UIAlertView+Blocks.h>
#import "Channel.h"

@interface LiveViewController ()

-(void)getLiveChannelUrl:(Channel*)channel;

@end

@implementation LiveViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    lblTitle.text = @"Trực tiếp";
    self.urlGetNews = @"lives";
    [self reloadNews];
    
}


//-(void)reloadNews{
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [parameters setObject:@"channel_online" forKey:@"action"];
//    [[Utils shareInstance] showLoadingView];
//    [manager GET:kLiveUrl parameters:[parameters addToken] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"response object live channels %@",responseObject);
//        [[Utils shareInstance] hideLoadingView];
//        [self processResponse:responseObject];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [[Utils shareInstance] hideLoadingView];
//    }];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *cell;
    NSDictionary *video = [self.arrayNews objectAtIndex:indexPath.row];

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
    
    cell.title = [video objectForKey:@"title"];
    cell.thumbnailUrl = [video objectForKey:@"avatar"];
//    cell.dateCreated = [video objectForKey:@"play_time"];
//    cell.viewCount = [NSString stringWithFormat:@"%@ đ",[video objectForKey:@"price"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *liveChannel = [self.arrayNews objectAtIndex:indexPath.row];
    Channel *channel = [[Channel alloc] init];
    channel.channelId = [[liveChannel objectForKey:@"live_id"] intValue];
    channel.name = [liveChannel objectForKey:@"title"];
//    channel.time = [liveChannel objectForKey:@"play_time"];
//    channel.price = [[liveChannel objectForKey:@"price"] intValue];
    if ( channel.price == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:[NSString stringWithFormat:@"Bạn có muốn xem chương trình này với giá %dđ/15 phút",[[liveChannel objectForKey:@"price"] intValue]] delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Có", nil];
        alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == alertView.firstOtherButtonIndex) {
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                [parameters setObject:@"live_pay_confirm" forKey:@"action"];
                [parameters setObject:[NSString stringWithFormat:@"%d",channel.channelId] forKey:@"params_channelid"];
                [parameters setObject:SharedAppDelegate.user.token forKey:@"params_memberkey"];
                [[Utils shareInstance] showLoadingView];
                [manager GET:kLiveUrl parameters:[parameters addToken] success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"response object confirm pay %@",responseObject);

                    if([[responseObject objectForKey:@"status"] intValue]==2){
                        [self getLiveChannelUrl:channel];
                    }
                    [[Utils shareInstance] hideLoadingView];

                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [[Utils shareInstance] hideLoadingView];
                }];
            } else if (buttonIndex == alertView.cancelButtonIndex) {
                NSLog(@"Cancelled.");
            }
        };
        
        [alertView show];
    }
    else{
//        [self getLiveChannelUrl:channel];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setObject:@"live_pay_confirm" forKey:@"action"];
        [parameters setObject:[NSString stringWithFormat:@"%d",channel.channelId] forKey:@"params_channelid"];
        [parameters setObject:SharedAppDelegate.user.token forKey:@"params_memberkey"];
        [[Utils shareInstance] showLoadingView];
        [manager GET:kLiveUrl parameters:[parameters addToken] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response object confirm pay %@",responseObject);
            [self getLiveChannelUrl:channel];
            [[Utils shareInstance] hideLoadingView];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[Utils shareInstance] hideLoadingView];
        }];
    }
}

-(void)getLiveChannelUrl:(Channel*)channel{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@"live_url_token" forKey:@"action"];
    [parameters setObject:[NSString stringWithFormat:@"%d",channel.channelId] forKey:@"params_channelid"];
    [parameters setObject:SharedAppDelegate.user.token forKey:@"params_memberkey"];
    [parameters setObject:@"abcdxyz" forKey:@"params_phoneid"];
    [manager GET:kLiveUrl parameters:[parameters addToken] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response object live url %@",responseObject);

        if ([[responseObject objectForKey:@"status"] intValue] == 0) {
            channel.channelUrl = [[responseObject objectForKey:@"data"] objectForKey:@"stream_url"];
            [SharedAppDelegate showSecondControllerWithChannel:channel];
        }
        else{
            [[[OLGhostAlertView alloc] initWithTitle:[responseObject objectForKey:@"mss"]] show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
