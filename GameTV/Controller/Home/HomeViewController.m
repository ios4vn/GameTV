//
//  HomeViewController.m
//  GameTV
//
//  Created by Hai Trieu on 3/18/15.
//  Copyright (c) 2015 Adriaenssen BVBA. All rights reserved.
//

#import "HomeViewController.h"
#import "VideoCell.h"
#import "SlideCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    if (!_category) {
        self.urlGetNews = @"posts&page=home&cid=diem-tin";
    }
    [self loadAds];
    [self reloadNews];
    
}

-(void)setCategory:(CategoryNews *)category{
    _category = category;
    self.urlGetNews = [NSString stringWithFormat:@"posts&page=home&cid=%@",_category.categoryId];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *logoHome;
    logoHome = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 42)];
    logoHome.image = [UIImage imageNamed:@"icon_game_header"];
    self.navigationItem.titleView = logoHome;
}


-(void)loadAds{
    NSString *urlRequest = [NSString stringWithFormat:@"%@getads",kDomain];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [SharedAppDelegate initAdmobFull];
    [manager GET:urlRequest parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *ads = [responseObject objectForKey:@"data"];
        SharedAppDelegate.customAds = ads;
        int randNum = rand() % 4;
        if (randNum) {
            SharedAppDelegate.adUnitID = kAdmobKey;
        }
        else {
            SharedAppDelegate.adUnitID = [[responseObject objectForKey:@"admobkey"] objectForKey:@"ios"];
        }

        NSDictionary *ad = [ads objectAtIndex:0];
        
        if ([[ad objectForKey:@"type"] isEqualToString:@"admob"]){
            SharedAppDelegate.adsType = AdsTypeGoogle;
        }
        else{
            SharedAppDelegate.adsType = AdsTypeCustom;
        }
        [self showAds:SharedAppDelegate.adsType];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *match = [self.arrayNews objectAtIndex:indexPath.row];
    [SharedAppDelegate showSecondControllerWithVideoId:[[match objectForKey:@"id"] doubleValue]];
    
}

@end
