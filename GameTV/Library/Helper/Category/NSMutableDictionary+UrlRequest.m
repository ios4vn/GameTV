//
//  NSMutableDictionary+UrlRequest.m
//  uClip
//
//  Created by Hai Trieu on 1/22/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import "NSMutableDictionary+UrlRequest.h"
#import "NSString+MD5.h"

@implementation NSMutableDictionary (UrlRequest)

-(NSString*)requestString{
//    NSMutableString *urlRequest = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@&ssid=%@",kDomain,SharedAppDelegate.user.token]];
    NSMutableString *urlRequest = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@",kDomain]];
    NSArray*keys=[self allKeys];
    for (NSString *key in keys) {
        [urlRequest appendString:[NSString stringWithFormat:@"&%@=%@",key,[self objectForKey:key]]];
    }
    return urlRequest;
}

-(NSString*)requestStringWithMD5{
    NSMutableString *urlRequest = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@",kDomain]];
    NSMutableString *token = [[NSMutableString alloc] init];
    NSArray*keys=[self allKeys];
    for (NSString *key in keys) {
        [urlRequest appendString:[NSString stringWithFormat:@"&%@=%@",key,[self objectForKey:key]]];
        [token appendString:[self objectForKey:key]];
    }
        [urlRequest appendString:[NSString stringWithFormat:@"&token=%@",[token MD5Hash]]];
    return urlRequest;
}

-(NSMutableDictionary*)addToken{
    [self setObject:kAppId forKey:@"app_id"];
    NSMutableString *token = [[NSMutableString alloc] init];
    NSArray*keys= [[self allKeys]sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    for (NSString *key in keys) {
        [token appendString:[self objectForKey:key]];
    }
    [token appendString:kApiKey];
    NSLog(@"token is %@",token);
    [self setObject:[token MD5Hash] forKey:@"token"];
    return self;
}
@end
