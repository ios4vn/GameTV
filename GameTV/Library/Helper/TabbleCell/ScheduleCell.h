//
//  ScheduleCell.h
//  GameTV
//
//  Created by thich on 4/11/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RTLabel.h"
@interface ScheduleCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *imgHomeThumbnail;
@property (nonatomic, strong) IBOutlet UILabel *lblHomeName;
@property (nonatomic, strong) IBOutlet UIImageView *imgAwayThumbnail;
@property (nonatomic, strong) IBOutlet UILabel *lblAwayName;
@property (nonatomic, strong) IBOutlet UIImageView *imgBien;
@property (nonatomic, strong) IBOutlet UIImageView *imgTime;
@property (nonatomic, strong) IBOutlet UILabel *lblTime;
/*@property (nonatomic, strong) RTLabel *rtLabel;
+ (RTLabel*)textLabel;*/
@end
