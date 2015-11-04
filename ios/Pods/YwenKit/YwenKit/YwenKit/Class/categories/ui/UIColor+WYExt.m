//
//  UIColor+WYExt.m
//  WYExtensions
//
//  Created by ywen on 15/3/11.
//
//

#import "UIColor+WYExt.h"

@implementation UIColor (WYExt)

+ (UIColor*) WY_ColorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*) WY_ColorWithHex:(NSInteger)hexValue
{
    return [UIColor WY_ColorWithHex:hexValue alpha:1.0];
}

@end
