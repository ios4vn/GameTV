//
//  AutoCompleteViewController.h
//  Music
//
//  Created by Hai Trieu on 5/28/13.
//  Copyright (c) 2013 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTListViewController.h"

@class AutoCompleteViewController;

@protocol AutoCompleteViewControllerDelegate <NSObject>

-(void)didSelectRow:(AutoCompleteViewController*)viewController;

@end

@interface AutoCompleteViewController : HTListViewController {

}

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, assign) id <AutoCompleteViewControllerDelegate> delegate;
@property (nonatomic, strong) UINavigationController *parentNavigationController;
@property (nonatomic, strong) NSString *keyword;

@end
