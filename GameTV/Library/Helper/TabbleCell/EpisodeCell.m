//
//  EpisodeCell.m
//  Vui1
//
//  Created by Hai Trieu on 12/30/14.
//  Copyright (c) 2014 Hai Trieu. All rights reserved.
//

#import "EpisodeCell.h"

@interface EpisodeCell ()

@property (nonatomic, strong) IBOutlet UILabel *lblEpisodeNumber;

@end

@implementation EpisodeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EpisodeCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)setEpisodeNumber:(NSString *)episodeNumber{

    _episodeNumber = episodeNumber;
    _lblEpisodeNumber.text = episodeNumber;
    
}

@end
