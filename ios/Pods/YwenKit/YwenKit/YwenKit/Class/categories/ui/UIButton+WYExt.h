//
//  UIButton+WYExt.h
//  YwenKit
//
//  Created by ywen on 15/5/13.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WYExt)

@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

-(void) WY_SetBgColor:(NSInteger) bgColor title:(NSString *) title titleColor:(NSInteger) titleColor corn:(CGFloat) corn fontSize: (CGFloat) fontSize;

-(void)WY_SetBgColor:(NSInteger)bgColor hlColor:(NSInteger)hlColor disableColor:(NSInteger)disableColor title:(NSString *)title titleColor:(NSInteger)titleColor corn:(CGFloat)corn fontSize:(CGFloat)fontSize;

-(void)WY_SetBgColor:(NSInteger)bgColor hlColor:(NSInteger)hlColor disableColor:(NSInteger)disableColor title:(NSString *)title titleColor:(NSInteger)titleColor hlTtitleColor:(NSInteger) hlTitleColor disableTitleColor:(NSInteger) disableTitleColor corn:(CGFloat)corn fontSize:(CGFloat)fontSize;

@end
