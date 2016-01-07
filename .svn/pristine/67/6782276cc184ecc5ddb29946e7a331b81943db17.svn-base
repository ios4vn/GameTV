//
//  AutoCompleteViewController.m
//  Music
//
//  Created by Hai Trieu on 5/28/13.
//  Copyright (c) 2013 Adriaenssen BVBA. All rights reserved.
//

#import "AutoCompleteViewController.h"
#import "SVPullToRefresh.h"
#import "SearchCell.h"

@interface AutoCompleteViewController () 

@end

@implementation AutoCompleteViewController

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
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"SearchCell"];
    
    pageSize = 3;
    
    self.tableView.showsPullToRefresh = NO;
    self.tableView.showsInfiniteScrolling = NO;
    canLoadMore = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    SearchCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    NSDictionary *aSearch = [self.arrayNews objectAtIndex:indexPath.row];
//    NSString *type = [aSearch objectForKey:@"type"];
//    
//    if ([type isEqualToString:@"video"]){
//        cell.type.image = [UIImage imageNamed:@"icon_video_sb"];
//    } else if([type isEqualToString:@"music"]) {
//        cell.type.image = [UIImage imageNamed:@"icon_baihat_sb"];
//    }

    cell.keyword.text = [aSearch objectForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(didSelectRow:)]) {
        [_delegate didSelectRow:self];
    }
    
    NSDictionary *match = [self.arrayNews objectAtIndex:indexPath.row];
    [SharedAppDelegate showSecondControllerWithVideoId:[[match objectForKey:@"id"] doubleValue]];
    
}

-(void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    self.urlGetNews = [[NSString stringWithFormat:@"search&q=%@",keyword] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self refreshContent];
}


@end
