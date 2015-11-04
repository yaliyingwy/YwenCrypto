//
//  UIImage+WYExt.m
//  YwenKit
//
//  Created by ywen on 15/5/3.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "UIImage+WYExt.h"
#import "UIColor+WYExt.h"

@implementation UIImage (WYExt)

-(UIImage *)WY_Strech:(CGFloat)horizontal vertical:(CGFloat)vertical {
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake((self.size.height - 1) / 2 + vertical, (self.size.width - 1) / 2 + horizontal, (self.size.height - 1) / 2 - vertical, (self.size.width - 1) / 2 - horizontal) resizingMode:UIImageResizingModeStretch];
}

+(UIImage *)WY_ImageWithColor:(NSInteger)color size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[UIColor WY_ColorWithHex:color].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+(UIImage *)WY_ImageWithColor:(NSInteger)color alpha:(CGFloat) alpha size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[UIColor WY_ColorWithHex:color alpha:alpha].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
