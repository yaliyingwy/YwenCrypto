//
//  UILabel+WYExt.m
//  YwenKit
//
//  Created by ywen on 15/5/13.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "UILabel+WYExt.h"
#import "UIColor+WYExt.h"

@implementation UILabel (WYExt)

-(void)WY_SetFontSize:(CGFloat)fontSize textColor:(NSInteger)color {
    self.font = [UIFont systemFontOfSize:fontSize];
    self.textColor = [UIColor WY_ColorWithHex:color];
}

@end
