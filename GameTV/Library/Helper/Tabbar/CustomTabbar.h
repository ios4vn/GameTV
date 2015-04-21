//
//  CustomTabbar.h
//  GameTV
//
//  Created by Hai Trieu on 4/6/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTabbarDelegate;

@interface CustomTabbar : UIView <UITabBarDelegate>

@property (nonatomic, assign) id <CustomTabbarDelegate> delegate;
@property (nonatomic, weak) IBOutlet UITabBar *tabbar;

@end

@protocol CustomTabbarDelegate <NSObject>

- (void)tabBar:(CustomTabbar *)tabBar didSelectAtIndex:(NSInteger)index;

@end
