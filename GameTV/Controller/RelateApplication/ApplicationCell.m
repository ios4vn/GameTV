//
//  ApplicationCell.m
//  NhacDj
//
//  Created by Hai Trieu on 11/3/14.
//  Copyright (c) 2014 Hai Trieu. All rights reserved.
//

#import "ApplicationCell.h"

@interface ApplicationCell ()

-(IBAction)btnInstallPress:(id)sender;

@end

@implementation ApplicationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAppId:(int)appId{
    _appId = appId;
}

-(IBAction)btnInstallPress:(id)sender{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:@"appInfo" forKey:@"act"];
//    [params setObject:[NSString stringWithFormat:@"%d",_appId] forKey:@"id"];
//    ASIHTTPRequest *_requestNews = [[ASIHTTPRequest alloc] initWithParams:params];
//    __weak ASIHTTPRequest *requestNews = _requestNews;
//    [requestNews setCompletionBlock:^{
//        SBJson4Parser *jsonParser = [SBJson4Parser parserWithBlock:^(id item, BOOL *stop) {
//            
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[item objectForKey:@"downloadLink"] objectForKey:@"ios"]]];
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

@end
