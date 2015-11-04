//
//  UIButton+WYExt.m
//  YwenKit
//
//  Created by ywen on 15/5/13.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "UIButton+WYExt.h"
#import "UIColor+WYExt.h"
#import "UIView+WYExt.h"
#import <objc/runtime.h>
#import "UIImage+WYExt.h"

@implementation UIButton (WYExt)

//MARK: 扩大button点击区域
@dynamic hitTestEdgeInsets;

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

-(void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) ||       !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}


-(void)WY_SetBgColor:(NSInteger)bgColor title:(NSString *)title titleColor:(NSInteger)titleColor corn:(CGFloat)corn fontSize:(CGFloat)fontSize {
    self.backgroundColor = [UIColor  WY_ColorWithHex: bgColor];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor WY_ColorWithHex:titleColor] forState:UIControlStateNormal];
    if (corn > 0) {
        [self WY_MakeCorn:corn];
    }
    self.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    
}

-(void)WY_SetBgColor:(NSInteger)bgColor hlColor:(NSInteger)hlColor disableColor:(NSInteger)disableColor title:(NSString *)title titleColor:(NSInteger)titleColor corn:(CGFloat)corn fontSize:(CGFloat)fontSize {
    [self WY_SetBgColor:bgColor title:title titleColor:titleColor corn:corn fontSize:fontSize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage *hlImage = [UIImage WY_ImageWithColor:hlColor size:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        
        UIImage *disableImage = [UIImage WY_ImageWithColor:disableColor size:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setBackgroundImage:hlImage forState:UIControlStateHighlighted];
            [self setBackgroundImage:disableImage forState:UIControlStateDisabled];
        });
        
    });
    
}

-(void)WY_SetBgColor:(NSInteger)bgColor hlColor:(NSInteger)hlColor disableColor:(NSInteger)disableColor title:(NSString *)title titleColor:(NSInteger)titleColor hlTtitleColor:(NSInteger)hlTitleColor disableTitleColor:(NSInteger)disableTitleColor corn:(CGFloat)corn fontSize:(CGFloat)fontSize {
    [self WY_SetBgColor:bgColor hlColor:hlColor disableColor:disableColor title:title titleColor:titleColor corn:corn fontSize:fontSize];
    [self setTitleColor:[UIColor WY_ColorWithHex: hlTitleColor] forState:UIControlStateHighlighted];
    
    [self setTitleColor:[UIColor WY_ColorWithHex:disableTitleColor] forState:UIControlStateDisabled];
}


@end
