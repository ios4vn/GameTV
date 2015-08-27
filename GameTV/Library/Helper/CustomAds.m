//
//  CustomAds.m
//  GameTV
//
//  Created by Hai Trieu on 5/12/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "CustomAds.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface CustomAds ()

@property (assign, nonatomic) int indexAd;
@property (weak, nonatomic) IBOutlet UIImageView *imageAd;
@property (strong, nonatomic) NSTimer *timer;
-(IBAction)btnAdsPress:(id)sender;

@end

@implementation CustomAds

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setAds:(NSArray *)ads{
    _ads = ads;
    [_timer invalidate];
    if ([_ads count] > 0) {
        _indexAd = -1;
        _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeAd) userInfo:nil repeats:YES];
    }
}

-(IBAction)btnAdsPress:(id)sender{

    NSDictionary *ad = [_ads objectAtIndex:_indexAd];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ad objectForKey:@"link"]]];
    
}

-(void)changeAd{
    _indexAd++;
    if (_indexAd == [_ads count]) {
        _indexAd = 0;
    }
    NSDictionary *ad = [_ads objectAtIndex:_indexAd];
    [_imageAd setImageWithURL:[NSURL URLWithString:[ad objectForKey:@"image"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
}

@end
