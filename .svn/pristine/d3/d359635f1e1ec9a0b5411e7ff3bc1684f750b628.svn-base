//
//  MenuCell.m
//  mKhoe
//
//  Created by Hai Trieu on 8/19/14.
//  Copyright (c) 2014 Adriaenssen BVBA. All rights reserved.
//

#import "MenuCell.h"

@interface MenuCell ()

@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UIImageView *imageIcon;

@end

@implementation MenuCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTittle:(NSString *)tittle{
    _tittle = tittle;
    _lblTitle.text = tittle;
}

-(void)setImageType:(NSString *)imageType{
    _imageType = imageType;
    NSString *imageNamed;
    if ([imageType isEqualToString:@"news"]) {
        imageNamed = @"sidebar_news";
    }
    else if ([imageType isEqualToString:@"aoe"]) {
        imageNamed = @"sidebar_deche";
    }
    else if ([imageType isEqualToString:@"lol"]) {
        imageNamed = @"sidebar_lol";
    }
    else if ([imageType isEqualToString:@"ff3"]) {
        imageNamed = @"sidebar_fifa";
    }
    else if ([imageType isEqualToString:@"cs"]) {
        imageNamed = @"sidebar_hl";
    }
    else {
        imageNamed = imageType;
    }

    _imageIcon.image = [UIImage imageNamed:imageNamed];
}

@end
