//
//  CustomAds.h
//  GameTV
//
//  Created by Hai Trieu on 5/12/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ads : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *link;

@end

@interface CustomAds : UIView

@property (strong, nonatomic) NSArray *ads;

@end
