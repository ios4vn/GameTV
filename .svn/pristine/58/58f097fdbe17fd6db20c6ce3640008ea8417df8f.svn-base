//
//  ConfirmPayViewController.m
//  uClip
//
//  Created by Hai Trieu on 2/4/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "ConfirmPayViewController.h"
#import "SBJson4.h"

@interface ConfirmPayViewController ()

@property (nonatomic, strong) IBOutlet UIWebView *wvPayment;

@end

@implementation ConfirmPayViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    timeLoad = 0;
    [_wvPayment loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlPayment]]];
    
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
#pragma mark UIWebViewDelegate

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    if (timeLoad == 1) {
//        NSData *jsonData = request.HTTPBody;
//        id jsonObj = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: nil];
//        NSLog(@"json obj 1 is %@",jsonObj);
//    }
//    else if (timeLoad == 2){
//        NSData *jsonData = request.HTTPBody;
//        id jsonObj = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: nil];
//        NSLog(@"json obj 2 is %@",jsonObj);
//    }
//    return YES;
//}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[Utils shareInstance] showLoadingView];
    timeLoad++;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[Utils shareInstance] hideLoadingView];
    if (_isRegisted) {
        if ([_delegate respondsToSelector:@selector(dissmisForm)]) {
            [[[OLGhostAlertView alloc] initWithTitle:@"Huỷ thành công"] show];
            [_delegate dissmisForm];
        }
    }
    else if (timeLoad == 2) {
        NSString *html = [webView stringByEvaluatingJavaScriptFromString:
                          @"document.body.innerHTML"];
        if (html.length < 59) {
            if ([_delegate respondsToSelector:@selector(dissmisForm)]) {
                [_delegate dissmisForm];
            }
        }
        NSString *jsonString = [html substringWithRange:NSMakeRange(59, html.length - 59 - 6)];
        SBJson4Parser *jsonParser = [SBJson4Parser parserWithBlock:^(id item, BOOL *stop) {

            [[[OLGhostAlertView alloc] initWithTitle:[item objectForKey:@"message"]] show];
            
        } allowMultiRoot:YES unwrapRootArray:NO errorHandler:^(NSError *error) {

        }];
        [jsonParser parse:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        
        if ([_delegate respondsToSelector:@selector(dissmisForm)]) {
            [_delegate dissmisForm];
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[Utils shareInstance] hideLoadingView];
}
@end
