//
//  UIView+WYExt.h
//  xebest
//
//  Created by ywen on 15/3/11.
//  Copyright (c) 2015年 xianyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Macros.h>

@interface UIView (WYExt)

- (void) WY_MakeCorn: (CGFloat) radius;
-(void) WY_MakeBorder:(WyDirection) direction borderColor: (UIColor *) color lineWidth:(CGFloat) width;
-(void) WY_MakeCircleBorder: (CGFloat) width color: (UIColor *) color;
-(void) WY_SetBorder:(NSInteger) borderColor width:(CGFloat) borderWidth;
@end
