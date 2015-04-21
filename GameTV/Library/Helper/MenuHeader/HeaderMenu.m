//
//  HeaderMenu.m
//  GameTV
//
//  Created by Hai Trieu on 4/7/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "HeaderMenu.h"

@interface HeaderMenu ()

@property (nonatomic, weak) IBOutlet UILabel *lblSectionTitle;

@end

@implementation HeaderMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setSectionTitle:(NSString *)sectionTitle{
    
    _sectionTitle = sectionTitle;
    _lblSectionTitle.text = sectionTitle;
    
}
@end
