//
//  YwenAlert.h
//  YwenKit
//
//  Created by ywen on 15/4/27.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Macros.h"


@interface YwenAlert : NSObject <UIAlertViewDelegate>
@property (strong, nonatomic) NSString *title;

+(void) alert: (NSString *) msg vc: (UIViewController *) vc;
+(void) alertWithCancel: (NSString *) msg vc: (UIViewController *) vc;
+(void) alert:(NSString *)msg vc:(UIViewController *)vc confirmStr: (NSString *) confirmStr confirmCb: (CallBack) confirmCb cancelStr: (NSString *) cancelStr cancelCb: (CallBack) cancelCb;
+(void)alert:(NSString *)msg vc:(UIViewController *)vc confirmStr:(NSString *)confirmStr confirmCb:(CallBack)confirmCb;

+(void) setTitle: (NSString *) title;

@end
