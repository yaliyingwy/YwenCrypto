//
//  UIColor+WYExtension.h
//  WYExtensions
//
//  Created by ywen on 15/3/11.
//
//
#import <UIKit/UIKit.h>


@interface UIColor (WYExt)

+ (UIColor*) WY_ColorWithHex:(NSInteger)hexValue;
+ (UIColor*) WY_ColorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

@end
