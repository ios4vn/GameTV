//
//  SetCell.h
//  GameTV
//
//  Created by Hai Trieu on 4/13/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EpisodeType) {
    EpisodeTypeC = 0,
    EpisodeTypeMatch
};

@protocol SetCellDelegate;

@interface SetCell : UITableViewCell

@property (nonatomic, assign) EpisodeType type;
@property (nonatomic, strong) NSArray *sets;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;
@property (nonatomic, assign) id <SetCellDelegate> delegate;

@end

@protocol SetCellDelegate <NSObject>

-(void)didSelect:(SetCell*)cell atIndex:(int)index;

@end
