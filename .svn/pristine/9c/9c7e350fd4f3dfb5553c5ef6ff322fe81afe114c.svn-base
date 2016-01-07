//
//  ValidViewController.m
//  Sport
//
//  Created by Hai Trieu on 3/20/13.
//
//

#import "ValidViewController.h"
#import "OLGhostAlertView.h"
#import "ServiceViewController.h"
@interface ValidViewController ()
-(BOOL)validateForm;
@end

@implementation ValidViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableView.tableFooterView = footerView;
    
    self.title = @"Xác thực";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)validBtnPress:(id)sender{
    if (![self validateForm]) {
        return;
    }
    [validTxt resignFirstResponder];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"activeaccount" forKey:@"act"];
    [params setObject:validTxt.text forKey:@"activecode"];
    [params setObject:[standardUserDefaults objectForKey:@"PhoneNumber"] forKey:@"phone"];
//    ASIFormDataRequest *_requestNews = [[ASIFormDataRequest alloc] initWithParams:params];
//    __weak ASIFormDataRequest *requestNews = _requestNews;
//    [requestNews setCompletionBlock:^{
//        SBJson4Parser *jsonParser = [SBJson4Parser parserWithBlock:^(id item, BOOL *stop) {
//            
//            NSLog(@"item valid is %@",item);
//            if ([[item objectForKey:@"status"] intValue] == 200) {
//
//            }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return validCell;
}
-(BOOL)validateForm{
    if ([validTxt.text length] <1) {
        OLGhostAlertView *alertView = [[OLGhostAlertView alloc] initWithTitle:@"Bạn chưa nhập mã xác thực"];
        [alertView show];
        return NO;
    }
    return YES;
}
@end
