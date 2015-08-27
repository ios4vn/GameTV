//
//  HTCollectionViewController.m
//  Vui1
//
//  Created by Hai Trieu on 12/22/14.
//  Copyright (c) 2014 Hai Trieu. All rights reserved.
//

#import "HTCollectionViewController.h"

@interface HTCollectionViewController ()

@end

@implementation HTCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayNews = [NSMutableArray array];

    [self setupScrollView];
}

-(void)setupScrollView{
    if (self.style == INSPullToRefreshStylePreserveContentInset) {
        self.collectionView.contentInset = UIEdgeInsetsMake(100.0f, 0.0f, 100.0f, 0.0f);
    }
    
    
    [self.collectionView ins_addPullToRefreshWithHeight:60.0 handler:^(UIScrollView *scrollView) {
        [self refreshContentWithBlock:^(id responseObject) {
            [scrollView ins_endPullToRefresh];
        }];
    }];
    
    self.collectionView.ins_pullToRefreshBackgroundView.preserveContentInset = NO;
    if (self.style == INSPullToRefreshStylePreserveContentInset) {
        self.collectionView.ins_pullToRefreshBackgroundView.preserveContentInset = YES;
    }
    
    if (self.style == INSPullToRefreshStyleText) {
        self.collectionView.ins_pullToRefreshBackgroundView.dragToTriggerOffset = 60.0;
    }
    
    [self.collectionView ins_addInfinityScrollWithHeight:60 handler:^(UIScrollView *scrollView) {
        
        int64_t delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self.collectionView performBatchUpdates:^{

                
            } completion:nil];
            
            [scrollView ins_endInfinityScroll];
            
        });
    }];
    
    UIView <INSAnimatable> *infinityIndicator = [self infinityIndicatorViewFromCurrentStyle];
    [self.collectionView.ins_infiniteScrollBackgroundView addSubview:infinityIndicator];
    [infinityIndicator startAnimating];
    
    self.collectionView.ins_infiniteScrollBackgroundView.preserveContentInset = NO;
    
    if (self.style == INSPullToRefreshStylePreserveContentInset) {
        self.collectionView.ins_infiniteScrollBackgroundView.preserveContentInset = YES;
    }
    
    UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [self pullToRefreshViewFromCurrentStyle];
    self.collectionView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
    [self.collectionView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshContentWithBlock:(void(^)(id responseObject))completion{
    _pageNumber = 0;
    gettingMore = YES;
    [self.arrayNews removeAllObjects];
    [self loadContentWithBlock:^(id responseObject) {
        completion(responseObject);
    }];
}

-(void)loadContentWithBlock:(void(^)(id responseObject))completion{
    
    _pageNumber++;
    NSString *urlRequest = [NSString stringWithFormat:@"%@%@&p=%d&limit=%d&ssid=%@",kDomain,self.urlGetNews,_pageNumber,kPageSize,SharedAppDelegate.user.token];
    NSLog(@"url request is %@",urlRequest);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlRequest parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self processResponse:responseObject];
        if (completion) {
            completion(responseObject);
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (completion) {
            completion(error);
        }
        NSLog(@"Error: %@", error);
        
    }];
    

    
}

-(void)processResponse:(id)responseObject{
    id item;
    if (_keyData) {
        item = [[responseObject objectForKey:@"data"] objectForKey:_keyData];
    }
    else{
        item = [responseObject objectForKey:@"data"] ;
    }

    NSArray *tmpNews;
    if ([item isKindOfClass:[NSArray class]]) {

        tmpNews = item;
        if ([tmpNews count] < kPageSize) {
            reachEnd = YES;
        }
        for (NSDictionary *aPhoto in tmpNews) {
            NSMutableDictionary *editablePhoto = [NSMutableDictionary dictionaryWithDictionary:aPhoto];

            [self.arrayNews addObject:editablePhoto];
        }
        [self.collectionView reloadData];
    }
    else{
        reachEnd = YES;
        return;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.arrayNews.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
    
    return cell;
}


@end
