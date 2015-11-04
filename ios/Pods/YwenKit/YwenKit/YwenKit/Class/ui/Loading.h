//
//  Loading.h
//  b2c
//
//  Created by ywen on 15/7/15.
//
//

#import <UIKit/UIKit.h>

@interface Loading : UIView
{
    UIWindow *_window;
    
    UIActivityIndicatorView *_activity;
    UIView *_dialogView;
    UILabel *_dialogLabel;
    NSTimeInterval _timeout;
    
    NSTimer *_timer;
}

@property (assign, nonatomic) NSTimeInterval timeout;

+(void) setTimeout:(NSTimeInterval) timeout;

+(void) show:(NSString *) message isForce: (BOOL) isForce;
+(void) hide;

@end
