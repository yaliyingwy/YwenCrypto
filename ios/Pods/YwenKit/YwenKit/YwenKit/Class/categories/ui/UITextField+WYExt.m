//
//  UITextField+WYExt.m
//  YwenKit
//
//  Created by ywen on 15/5/13.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "UITextField+WYExt.h"

@implementation UITextField (WYExt)

-(void)WY_SetLeftSpace:(CGFloat)spaceWidth {
    UIView *space = [[UIView alloc] initWithFrame:CGRectMake(0, 0, spaceWidth, 1)];
    self.leftView = space;
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(void)WY_SetRightSpace:(CGFloat)spaceWidth {
    UIView *space = [[UIView alloc] initWithFrame:CGRectMake(0, 0, spaceWidth, 1)];
    self.rightView = space;
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end
