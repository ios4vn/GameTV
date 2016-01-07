//
//  ApplicationDetailViewController.m
//  NhacDj
//
//  Created by Hai Trieu on 11/3/14.
//  Copyright (c) 2014 Hai Trieu. All rights reserved.
//

#import "ApplicationDetailViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface ApplicationDetailViewController ()

@property (nonatomic, strong) IBOutlet UILabel *lblName;
@property (nonatomic, strong) IBOutlet UILabel *lblDescription;
@property (nonatomic, strong) IBOutlet UIImageView *imgIcon;

-(IBAction)btnInstallPress:(id)sender;

@end

@implementation ApplicationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblName.text = [_appInfo objectForKey:@"title"];
    _lblDescription.text = [_appInfo objectForKey:@"description"];
//    [_imgIcon setImageWithURL:[NSURL URLWithString:[_appInfo objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"no_image"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        
//    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:@"appInfo" forKey:@"act"];
//    [params setObject:[_appInfo objectForKey:@"id"] forKey:@"id"];
//    ASIHTTPRequest *_requestNews = [[ASIHTTPRequest alloc] initWithParams:params];
//    __weak ASIHTTPRequest *requestNews = _requestNews;
//    [requestNews setCompletionBlock:^{
//        SBJson4Parser *jsonParser = [SBJson4Parser parserWithBlock:^(id item, BOOL *stop) {
//            _appInfo = item;
//            [mainContent loadHTMLString:[[[item objectForKey:@"appInfo"] objectAtIndex:0] objectForKey:@"content"] baseURL:nil];
//            lblTitle.text = [[[item objectForKey:@"appInfo"] objectAtIndex:0] objectForKey:@"title"] ;
//            
//        } allowMultiRoot:YES unwrapRootArray:NO errorHandler:^(NSError *error) {
//            
//        }];
//        
//        [jsonParser parse:[[requestNews responseString] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//    }];
//    
//    [requestNews startAsynchronous];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(IBAction)btnInstallPress:(id)sender{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[_appInfo objectForKey:@"downloadLink"] objectForKey:@"ios"]]];
}

@end
