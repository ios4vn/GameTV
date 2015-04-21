//
//  NSMutableDictionary+UrlRequest.h
//  uClip
//
//  Created by Hai Trieu on 1/22/15.
//  Copyright (c) 2015 Hai Trieu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (UrlRequest)

-(NSString*)requestString;
-(NSString*)requestStringWithMD5;
-(NSMutableDictionary*)addToken;

@end
