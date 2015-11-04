//
//  YwenGestureLockView.h
//  YwenKit
//
//  Created by ywen on 15/8/4.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YwenGestureLockView;

@protocol LockViewDelegate <NSObject>

@optional
-(void) lockView:(YwenGestureLockView *) lockView didBeginWithPasscode:(NSString *) passCode;
-(void) lockView:(YwenGestureLockView *) lockView didEndWithPasscode:(NSString *) passCode;
-(void) lockView:(YwenGestureLockView *) lockView didCancelWithPasscode:(NSString *) passCode;

@end

@interface YwenGestureLockView : UIView
{
    CGPoint _trackedLocation;
}

@property (strong, nonatomic, readonly) NSMutableArray *buttons;
@property (strong, nonatomic, readonly) NSMutableArray *selectedButtons;
@property (assign, nonatomic) NSUInteger numberOfNodes;
@property (assign, nonatomic) NSUInteger nodesPerRow;
@property (strong, nonatomic) UIImage *nodeImage;
@property (strong, nonatomic) UIImage *nodeImageSelected;
@property (strong, nonatomic) UIColor *lineColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) UIEdgeInsets contentInsets;
@property (weak, nonatomic) id<LockViewDelegate> delegate;
@property (assign, nonatomic) CGFloat nodeSize;

-(void) createUI;

@end
