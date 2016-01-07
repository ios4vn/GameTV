//
//  BSVideoDetailController.h
//  YouTubeDraggableVideo
//
//  Created by Sandeep Mukherjee on 02/02/15.
//  Copyright (c) 2015 Sandeep Mukherjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPlayerLayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "ShowPageCell.h"
#import "SetCell.h"
#import "Channel.h"
#import "StandarViewController.h"

@protocol RemoveViewDelegate
- (void)removeController;
@end

typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
    UIPanGestureRecognizerDirectionUndefined,
    UIPanGestureRecognizerDirectionUp,
    UIPanGestureRecognizerDirectionDown,
    UIPanGestureRecognizerDirectionLeft,
    UIPanGestureRecognizerDirectionRight
};

@interface BSVideoDetailController : StandarViewController<UIGestureRecognizerDelegate,UITextViewDelegate,UIWebViewDelegate,SetCellDelegate>{
    
    IBOutlet UISlider *movieTimeControl;
    IBOutlet UIActivityIndicatorView *loadingIndicator;
    IBOutlet UILabel *currentTime;
    IBOutlet UILabel *remainTime;
    IBOutlet UIButton *playBtn;
    IBOutlet UIButton *stopBtn;
    IBOutlet UIButton *fullScreenBtn;
    IBOutlet UIView *uvBgControls;
    IBOutlet UIView *uvControls;
    IBOutlet UILabel *ipAddress;
    CGRect minimizeRect;
    
    BOOL isSeeking;
    BOOL seekToZeroBeforePlay;
    float restoreAfterScrubbingRate;
    BOOL isControlShow;
    BOOL isFullScreen;

    ShowPageCell *showPageCell;
    
    id timeObserver;
    
    UIPanGestureRecognizer *pan;
    
}

@property (nonatomic, assign) double videoId;
@property (nonatomic, strong) Channel *channel;
@property (nonatomic, assign) BOOL isLive;

@property (nonatomic, strong) NSDictionary *videoDetail;
@property (nonatomic, assign) int currentC;

@property (nonatomic, assign) id  <RemoveViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *viewYouTube;
@property (weak, nonatomic) IBOutlet UIView *viewTable;

@property (strong, nonatomic) IBOutlet MyPlayerLayerView *playerLayerView;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (weak, nonatomic) IBOutlet UIView *viewShare;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchName;
@property (nonatomic, weak) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIView *viewGrowingTextView;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) UIWebView *webViewDisplay;
@property (nonatomic, retain) UIFont *textFont;

@property (weak, nonatomic) IBOutlet UIButton *btnDown;
@property (weak, nonatomic) IBOutlet UITextView *txtViewGrowing;

- (IBAction)btnDownTapAction:(id)sender;
- (IBAction)btnSendAction:(id)sender;
- (IBAction)showFullScreen:(id)sender;
- (CGPoint)randomPointInRect:(CGRect)rect;


@property(nonatomic)CGRect initialFirstViewFrame;
@property(nonatomic,strong) UIPanGestureRecognizer *panRecognizer;
@property(nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnDownBottomLayout;
-(void)removeView;
@property(nonatomic,strong) UIView *onView;

@end
