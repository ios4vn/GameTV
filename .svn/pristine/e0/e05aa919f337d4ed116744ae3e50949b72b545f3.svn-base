//
//  HTCollectionViewController.h
//  Vui1
//
//  Created by Hai Trieu on 12/22/14.
//  Copyright (c) 2014 Hai Trieu. All rights reserved.
//

#import "INSBaseViewController.h"

@interface HTCollectionViewController : INSBaseViewController {
    BOOL gettingMore;
    BOOL reachEnd;
}

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSString *keyData;
@property (nonatomic, assign) int pageNumber;
@property (nonatomic, strong) NSString *urlGetNews;
@property (nonatomic, strong) NSMutableArray *arrayNews;

-(void)refreshContentWithBlock:(void(^)(id responseObject))completion;
-(void)loadContentWithBlock:(void(^)(id responseObject))completion;
-(void)processResponse:(id)responseObject;

@end
