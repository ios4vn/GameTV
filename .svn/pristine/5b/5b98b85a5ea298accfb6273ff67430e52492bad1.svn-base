//
//  ConfirmPayViewController.h
//  uClip
//
//  Created by Hai Trieu on 2/4/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfirmPaymentDelegate;

@interface ConfirmPayViewController : UIViewController <UIWebViewDelegate>{
    int timeLoad;
}

@property (nonatomic, strong) NSString *urlPayment;
@property (nonatomic, assign) BOOL isRegisted;
@property (assign, nonatomic) id <ConfirmPaymentDelegate>delegate;

@end

@protocol ConfirmPaymentDelegate<NSObject>
@optional
- (void)dissmisForm;
@end