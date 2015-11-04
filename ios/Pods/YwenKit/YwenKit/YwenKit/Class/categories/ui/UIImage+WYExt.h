//
//  UIImage+WYExt.h
//  YwenKit
//
//  Created by ywen on 15/5/3.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WYExt)

-(UIImage *) WY_Strech:(CGFloat) horizontal vertical:(CGFloat) vertical;
+(UIImage *)WY_ImageWithColor:(NSInteger)color size:(CGSize)size;
+(UIImage *)WY_ImageWithColor:(NSInteger)color alpha:(CGFloat) alpha size:(CGSize)size;

@end
