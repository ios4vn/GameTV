//
//  CustomTabbar.m
//  GameTV
//
//  Created by Hai Trieu on 4/6/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "CustomTabbar.h"

@implementation CustomTabbar

-(void)awakeFromNib{
    [_tabbar setSelectedItem:0];
}

-(IBAction)didSelectButton:(id)sender{

    [_delegate tabBar:self didSelectAtIndex:1];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

    [_delegate tabBar:self didSelectAtIndex:[tabBar.items indexOfObject:item]];
    
}
@end
