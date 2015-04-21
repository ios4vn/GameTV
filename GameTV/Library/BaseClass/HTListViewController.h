//
//  HTListViewViewController.h
//  Music
//
//  Created by Hai Trieu on 5/3/13.
//  Copyright (c) 2013 Adriaenssen BVBA. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "INSBaseViewController.h"
#import "SVPullToRefresh.h"

@interface HTListViewController : INSBaseViewController{
    int pageNumber;
    int pageSize;
    BOOL canLoadMore;
    BOOL gettingMore;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL gettingMore;
@property (nonatomic, strong) UIView *footerIndicator;
@property (nonatomic, assign) int pageNumber;
@property (nonatomic, strong) NSString *urlGetNews;
@property (nonatomic, strong) NSMutableArray *arrayNews;
@property (nonatomic, strong) NSString *keyArrayData;

-(void)reloadNews;
-(void)refreshContent;
-(void)updateTableView:(NSArray *)tmpNews;
-(void)processResponse:(id)responseString;


@end
