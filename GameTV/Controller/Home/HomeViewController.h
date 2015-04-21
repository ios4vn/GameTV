//
//  HomeViewController.h
//  GameTV
//
//  Created by Hai Trieu on 3/18/15.
//  Copyright (c) 2015 Adriaenssen BVBA. All rights reserved.
//

#import "HTListViewController.h"
#import "Category.h"

@interface HomeViewController : HTListViewController

@property (nonatomic, strong) CategoryNews *category;

@end
