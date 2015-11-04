//
//  Toast.h
//  b2c
//
//  Created by ywen on 15/7/15.
//
//

#import <UIKit/UIKit.h>

@interface Toast : UIView

+(void)showToastWithContent:(NSString *)content;
+(void)showToastWithContent:(NSString *)content showTime:(NSTimeInterval)showTime postion:(NSInteger) postion;
+(void) showErr:(NSString *) message;
+(void) showSuccess:(NSString *) message;

@end
