//
//  VideoCell.m
//  NhacDj
//
//  Created by Hai Trieu on 10/1/14.
//  Copyright (c) 2014 Hai Trieu. All rights reserved.
//

#import "VideoCell.h"

@interface VideoCell ()

@property (nonatomic, strong) IBOutlet UILabel *lblViewCount;
@property (nonatomic, strong) IBOutlet UILabel *lblDateCreated;

@end

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setViewCount:(NSString *)viewCount{
    
    _lblViewCount.text = viewCount;
    
}

-(void)setDateCreated:(NSString *)dateCreated{

    _lblDateCreated.text = dateCreated;
}

@end
