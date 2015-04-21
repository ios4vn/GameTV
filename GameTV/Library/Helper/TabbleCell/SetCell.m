//
//  SetCell.m
//  GameTV
//
//  Created by Hai Trieu on 4/13/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "SetCell.h"
#import "EpisodeCell.h"

static NSString *kEpisodeCell = @"EpisodeCell";

@interface SetCell ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end


@implementation SetCell

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
    [self.collectionView registerClass:[EpisodeCell class] forCellWithReuseIdentifier:kEpisodeCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSets:(NSArray *)sets{
    _sets = sets;
    [self.collectionView reloadData];
}

#pragma mark UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //    return 0;
    return [_sets count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EpisodeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEpisodeCell forIndexPath:indexPath];
    
    cell.episodeNumber = [NSString stringWithFormat:@"%@ %d",_prefix,indexPath.row+1];
    if (self.selectedItemIndexPath != nil && [indexPath compare:self.selectedItemIndexPath] == NSOrderedSame) {
        cell.layer.borderColor = [[UIColor redColor] CGColor];
        cell.layer.borderWidth = 1.0;
    } else {
        cell.layer.borderColor = nil;
        cell.layer.borderWidth = 0.0;
    }
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *indexPaths = [NSMutableArray arrayWithObject:indexPath];
    
    if (self.selectedItemIndexPath)
    {
        // if we had a previously selected cell
        
        if ([indexPath compare:self.selectedItemIndexPath] == NSOrderedSame)
        {
            // if it's the same as the one we just tapped on, then we're unselecting it
            
            self.selectedItemIndexPath = nil;
        }
        else
        {
            // if it's different, then add that old one to our list of cells to reload, and
            // save the currently selected indexPath
            
            [indexPaths addObject:self.selectedItemIndexPath];
            self.selectedItemIndexPath = indexPath;
        }
    }
    else
    {
        // else, we didn't have previously selected cell, so we only need to save this indexPath for future reference
        
        self.selectedItemIndexPath = indexPath;
    }
    
    // and now only reload only the cells that need updating
    
    [collectionView reloadItemsAtIndexPaths:indexPaths];
    if ([_delegate respondsToSelector:@selector(didSelect:atIndex:)]) {
        [_delegate didSelect:self atIndex:indexPath.row];
    }
}

@end
