//
//  UIColor+Hex.h
//
//  Created by Tom Adriaenssen on 13/01/11.
//

@interface UIColor (Hex) 
+ (UIColor*) colorWithCSS: (NSString*) css;
+ (UIColor*) colorWithHex: (NSUInteger) hex;
+ (UIColor*) colorWithRank: (int)rank;

@end
