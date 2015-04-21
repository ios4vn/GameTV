//
//  HTListViewViewController.m
//  Music
//
//  Created by Hai Trieu on 5/3/13.
//  Copyright (c) 2013 Adriaenssen BVBA. All rights reserved.
//

#import "HTListViewController.h"
#import "SBJson4.h"

@interface  HTListViewController ()

//-(void)setupTableView;

@end

@implementation HTListViewController

@synthesize tableView = _tableView;
@synthesize gettingMore;
@synthesize arrayNews = _arrayNews;
@synthesize pageNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (_arrayNews == nil) {
        self.arrayNews = [[NSMutableArray alloc] init];
    }

    pageSize = kPageSize;
    pageNumber = kPageNumber;

    [self setupScrollView];
}

-(void)setupScrollView{
    if (self.style == INSPullToRefreshStylePreserveContentInset) {
        self.tableView.contentInset = UIEdgeInsetsMake(100.0f, 0.0f, 100.0f, 0.0f);
    }
    
    
    [self.tableView ins_addPullToRefreshWithHeight:60.0 handler:^(UIScrollView *scrollView) {
        int64_t delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self refreshContent];
            [scrollView ins_endPullToRefresh];
            
        });
    }];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.ins_pullToRefreshBackgroundView.preserveContentInset = NO;
    if (self.style == INSPullToRefreshStylePreserveContentInset) {
        self.tableView.ins_pullToRefreshBackgroundView.preserveContentInset = YES;
    }
    
    if (self.style == INSPullToRefreshStyleText) {
        self.tableView.ins_pullToRefreshBackgroundView.dragToTriggerOffset = 60.0;
    }
    
    [self.tableView ins_addInfinityScrollWithHeight:60 handler:^(UIScrollView *scrollView) {
        
        int64_t delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            pageNumber++;
            [self reloadNews];
            [scrollView ins_endInfinityScroll];
        });
    }];
    
    UIView <INSAnimatable> *infinityIndicator = [self infinityIndicatorViewFromCurrentStyle];
    [self.tableView.ins_infiniteScrollBackgroundView addSubview:infinityIndicator];
    [infinityIndicator startAnimating];
    
    self.tableView.ins_infiniteScrollBackgroundView.preserveContentInset = NO;
    
    if (self.style == INSPullToRefreshStylePreserveContentInset) {
        self.tableView.ins_infiniteScrollBackgroundView.preserveContentInset = YES;
    }
    
    UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [self pullToRefreshViewFromCurrentStyle];
    self.tableView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
    [self.tableView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrayNews count];
}

-(void)reloadNews{
    if (pageNumber == 0 && _footerIndicator == nil) {
        self.footerIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, 88, 320, 44)];
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicator.frame = CGRectMake(151, 11, 20, 20);
        [indicator startAnimating];
        [self.footerIndicator addSubview:indicator];
        [self.view addSubview:self.footerIndicator];
    }

    NSString *urlRequest = [NSString stringWithFormat:@"%@%@&p=%d&limit=%d",kDomain,self.urlGetNews,pageNumber,kPageSize];
    NSLog(@"url request is %@",urlRequest);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlRequest parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        gettingMore = NO;
        [_tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:0];
        if ([self.footerIndicator superview]) {
            [self.footerIndicator removeFromSuperview];
            self.footerIndicator.hidden = YES;
        }

        [self processResponse:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        gettingMore = NO;
        NSLog(@"fail is %@",[error description]);

        [_tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:0];
        if ([self.footerIndicator superview]) {
            [self.footerIndicator removeFromSuperview];
        }
        
    }];
    
    gettingMore = YES;

}

-(void)refreshContent{
    pageNumber = 0;
    if (canLoadMore == YES) {
        self.tableView.showsInfiniteScrolling = YES;
    }
    [self reloadNews];
}

-(void)updateTableView:(NSArray *)tmpNews{
    if (pageNumber == 0) {
        [self.arrayNews removeAllObjects];
    }
    
    for (NSDictionary *dict in tmpNews) {
        [self.arrayNews addObject:dict];
    }
    
    if ([tmpNews count] < pageSize) {
        self.tableView.showsInfiniteScrolling = NO;
        [self.tableView ins_removeInfinityScroll];
    }
    if (pageNumber == 0) {
        
        [[self tableView] reloadData];
        
    }
    else{
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        
        for (NSInteger i=pageNumber*pageSize; i < pageNumber*pageSize + [tmpNews count]; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [[self tableView] beginUpdates];
        [[self tableView] insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        
        [[self tableView] endUpdates];
    }
}

-(void)processResponse:(id)responseString{
    
    NSArray *tmpNews;
    if ([[responseString objectForKey:@"data"] isKindOfClass:[NSArray class]]) {

        tmpNews = [responseString objectForKey:@"data"];
        [self updateTableView:tmpNews];
        
    }
    else if ([[[responseString objectForKey:@"data"] objectForKey:_keyArrayData] isKindOfClass:[NSArray class]])
    {
        tmpNews = [[responseString objectForKey:@"data"] objectForKey:_keyArrayData];
        [self updateTableView:tmpNews];
    }
    else{
        tmpNews = [NSArray array];
    }
    
}

@end
