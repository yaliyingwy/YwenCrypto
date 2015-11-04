//
//  Toast.m
//  b2c
//
//  Created by ywen on 15/7/15.
//
//

#import "Toast.h"
#import "YwenKit.h"

@implementation Toast

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(void)showToastWithContent:(NSString *)content showTime:(NSTimeInterval)showTime postion:(NSInteger)postion {
    Toast *toast = [Toast new];
    toast.translatesAutoresizingMaskIntoConstraints = NO;
    toast.backgroundColor = [UIColor clearColor];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:toast];
    
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[toast]-|"
                                                options:0
                                                metrics:nil
                                                views:NSDictionaryOfVariableBindings(toast)];
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[toast]-|"
                                                                    options:0
                                                                    metrics:nil
                                                                    views:NSDictionaryOfVariableBindings(toast)];
    [window addConstraints:constraints1];
    [window addConstraints:constraints2];
    
    
    if ([content isKindOfClass:[NSString class]] && content.length > 0) {
        UIView *dialogView = [UIView new];
        dialogView.backgroundColor = [UIColor blackColor];
        dialogView.alpha = 0.6;
        dialogView.translatesAutoresizingMaskIntoConstraints = NO;
        [dialogView WY_MakeCorn:6];
        [toast addSubview:dialogView];
        
        
        NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[dialogView]-(>=20)-|"
                                                    options:0
                                                    metrics:nil
                                                    views:NSDictionaryOfVariableBindings(dialogView)];
        [toast addConstraints:constraints3];
        
        CGFloat offset = 0.0;
        switch (postion) {
            case 1:
                offset = 0.4 * SCREEN_HEIGHT;
                break;
                
            case 2:
                offset = -0.05 * SCREEN_HEIGHT;
                break;
                
            case 3:
                offset = -0.3 * SCREEN_HEIGHT;
                
            default:
                break;
        }
        
        [toast addConstraint:[NSLayoutConstraint constraintWithItem:dialogView
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                         toItem:toast
                                                         attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                         constant:offset]];
        
        [toast addConstraint:[NSLayoutConstraint constraintWithItem:dialogView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                          toItem:toast
                                                          attribute:NSLayoutAttributeCenterX
                                                          multiplier:1
                                                          constant:0]];

        
        
        UILabel *dialogLabel = [UILabel new];
        [dialogLabel WY_SetFontSize:13 textColor:0xffffff];
        dialogLabel.textAlignment = NSTextAlignmentCenter;
        dialogLabel.text = content;
        dialogLabel.numberOfLines = 0;
        dialogLabel.lineBreakMode = NSLineBreakByWordWrapping;
        dialogLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [dialogView addSubview:dialogLabel];
        
        NSArray *constraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=16)-[dialogLabel]-(>=16)-|"
                                                                        options:0
                                                                        metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(dialogLabel)];
        
        NSArray *constraints5 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=12)-[dialogLabel]-(>=12)-|"
                                                                        options:0
                                                                        metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(dialogLabel)];
        
        [dialogView addConstraints:constraints4];
        [dialogView addConstraints:constraints5];
        
        //显示动画
        dialogView.alpha = 0;
        dialogView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:0.45 animations:^{
            dialogView.alpha = 0.6;
            dialogView.transform = CGAffineTransformMakeScale(1, 1);
        }];
        
        
        //移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(showTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.45 animations:^{
                dialogView.alpha = 0;
                dialogView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [toast removeFromSuperview];
            }];
        });
        
    }
    
}

+(void)showToastWithContent:(NSString *)content {
    [Toast showToastWithContent:content showTime:1.5 postion:1];
}

+(void)showSuccess:(NSString *)message {
    [[Toast new] showWith:message success:YES];
}

+(void)showErr:(NSString *)message {
    [[Toast new] showWith:message success:NO];
}

-(void) showWith:(NSString *) msg success:(BOOL) sucess {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor clearColor];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[self]-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(self)];
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[self]-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(self)];
    [window addConstraints:constraints1];
    [window addConstraints:constraints2];
    
    
    if ([msg isKindOfClass:[NSString class]] && msg.length > 0) {
        UIView *dialogView = [UIView new];
        dialogView.backgroundColor = [UIColor blackColor];
        dialogView.alpha = 0.6;
        dialogView.translatesAutoresizingMaskIntoConstraints = NO;
        [dialogView WY_MakeCorn:6];
        [self addSubview:dialogView];
        
        
        NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=30)-[dialogView]-(>=30)-|"
                                                                        options:0
                                                                        metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(dialogView)];
        [self addConstraints:constraints3];
        
        CGFloat offset = -0.05 * SCREEN_HEIGHT;
    
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:dialogView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:offset]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:dialogView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
        
        
        
        UIImage *statusImage;
        if (sucess == YES) {
            statusImage = [UIImage imageNamed:@"toast_success"];
        }
        else
        {
            statusImage = [UIImage imageNamed:@"toast_err"];
        }
        
        UIImageView *statusView = [[UIImageView alloc] initWithImage:statusImage];
        statusView.translatesAutoresizingMaskIntoConstraints = NO;
        [dialogView addSubview:statusView];
        
        [dialogView addConstraint:[NSLayoutConstraint constraintWithItem:statusView
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                              toItem:dialogView
                                                              attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                               constant:0]];
        
        UILabel *dialogLabel = [UILabel new];
        [dialogLabel WY_SetFontSize:13 textColor:0xffffff];
        dialogLabel.textAlignment = NSTextAlignmentCenter;
        dialogLabel.text = msg;
        dialogLabel.numberOfLines = 0;
        dialogLabel.lineBreakMode = NSLineBreakByWordWrapping;
        dialogLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [dialogView addSubview:dialogLabel];
        
        NSArray *constraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=16)-[dialogLabel]-(>=16)-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(dialogLabel)];
        
        NSArray *constraints5 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-17-[statusView]-8-[dialogLabel]-17-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(statusView, dialogLabel)];
        
        [dialogView addConstraints:constraints4];
        [dialogView addConstraints:constraints5];
        
        //显示动画
        dialogView.alpha = 0;
        dialogView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:0.2 animations:^{
            dialogView.alpha = 0.6;
            dialogView.transform = CGAffineTransformMakeScale(1, 1);
        }];
        
        
        //移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.45 animations:^{
                dialogView.alpha = 0;
                dialogView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        });
        
    }
}

@end
