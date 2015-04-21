//
//  BaseCell.h
//  NhacDj
//
//  Created by Hai Trieu on 9/29/14.
//  Copyright (c) 2014 Hai Trieu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface BaseCell : UITableViewCell

@property (nonatomic, weak) NSString *thumbnailUrl;
@property (nonatomic, strong) IBOutlet UIImageView *imgThumbnail;

@property (nonatomic, weak) NSString *title;
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;

@property (nonatomic, strong) NSString *viewCount;
@property (nonatomic, strong) NSString *dateCreated;

@end
