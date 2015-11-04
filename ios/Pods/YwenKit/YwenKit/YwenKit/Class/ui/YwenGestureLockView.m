//
//  YwenGestureLockView.m
//  YwenKit
//
//  Created by ywen on 15/8/4.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "YwenGestureLockView.h"
#import <YwenKit.h>

#define InvalidPoint CGPointMake(-1, -1)

@implementation YwenGestureLockView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

-(void) setDefaultValues {
    _lineColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
    _lineWidth = 10;
    _contentInsets = UIEdgeInsetsZero;
    _nodeSize = 80;
    
    _nodeImage = [UIImage imageNamed:@"gesture_node_normal"];
    _nodeImageSelected = [UIImage imageNamed:@"gesture_node_selected"];
    
    _numberOfNodes = 9;
    _nodesPerRow = 3;
    
    _selectedButtons = [NSMutableArray array];
    _buttons = [NSMutableArray array];
    
    _trackedLocation = InvalidPoint;
}

-(void) createUI {
    
    self.backgroundColor = [UIColor clearColor];
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor clearColor];
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_contentView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[_contentView]-%f-|", _contentInsets.left, _contentInsets.right]
                                                                options:0
                                                                metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_contentView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_contentView]-%f-|", _contentInsets.top, _contentInsets.bottom]
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_contentView)]];
    
    //延迟一下添加button，以便获取正确的frame
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat hMargin = (_contentView.bounds.size.width - _nodeSize * _nodesPerRow) / (_nodesPerRow - 1);
        NSUInteger rows = ceilf(_numberOfNodes * 1.0  / _nodesPerRow);
        CGFloat vMargin = (_contentView.bounds.size.height - _nodeSize * rows) / (rows - 1);
        
        for (int i = 0; i < _numberOfNodes; i++) {
            int row = i / _nodesPerRow;
            int col = i % _nodesPerRow;
            UIButton *btn = [[UIButton alloc] init];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [btn setImage:_nodeImage forState:UIControlStateNormal];
            [btn setImage:_nodeImageSelected forState:UIControlStateSelected];
            
            btn.tag = i;
            btn.userInteractionEnabled = NO;
            [_buttons addObject:btn];
            [_contentView addSubview:btn];
            CGFloat left = floor((_nodeSize + hMargin) * col);
            CGFloat top = floor((_nodeSize + vMargin) * row);
            
            [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[btn(==%f)]", left, _nodeSize]
                                                                                options:0
                                                                                metrics:nil
                                                                                   views: NSDictionaryOfVariableBindings(btn)]];
            [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[btn(==%f)]", top, _nodeSize]
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views: NSDictionaryOfVariableBindings(btn)]];
        }
    });
}

#pragma mark-  取得指定区域的node
-(UIButton *) nodeInPoint:(CGPoint) point {
    for (UIButton *btn in _buttons) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}


#pragma mark- 绘制路径
-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_selectedButtons.count > 0) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        UIButton *firstBtn = _selectedButtons.firstObject;
        [bezierPath moveToPoint:[self convertPoint:firstBtn.center fromView:_contentView]];
        for (int i = 1; i < _selectedButtons.count; i++) {
            UIButton *btn = _selectedButtons[i];
            [bezierPath addLineToPoint:[self convertPoint:btn.center fromView:_contentView]];
        }
        if (!CGPointEqualToPoint(_trackedLocation, InvalidPoint)) {
            [bezierPath addLineToPoint:[self convertPoint:_trackedLocation fromView:_contentView]];
        }
        
        bezierPath.lineWidth = _lineWidth;
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        [_lineColor setStroke];
        [bezierPath stroke];
        
    }
}

#pragma mark- 重写touch事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_contentView];
    if (CGRectContainsPoint(_contentView.bounds, point)) {
        UIButton *touchedBtn = [self nodeInPoint:point];
        if (touchedBtn != nil && [_selectedButtons indexOfObject:touchedBtn] == NSNotFound) {
            touchedBtn.selected = YES;
            [_selectedButtons addObject:touchedBtn];
            _trackedLocation = point;
            
            if ([self.delegate respondsToSelector:@selector(lockView:didBeginWithPasscode:)]) {
                [self.delegate lockView:self didBeginWithPasscode:[NSString stringWithFormat:@"%@", @(touchedBtn.tag)]];
            }
        }
    }
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_contentView];
    
    if (CGRectContainsPoint(_contentView.bounds, point)) {
        UIButton *touchedBtn = [self nodeInPoint:point];
        if (touchedBtn != nil && [_selectedButtons indexOfObject:touchedBtn] == NSNotFound) {
            touchedBtn.selected = YES;
            [_selectedButtons addObject:touchedBtn];
            if (_selectedButtons.count == 1) {
                //第一个点
                if ([self.delegate respondsToSelector:@selector(lockView:didBeginWithPasscode:)]) {
                    [self.delegate lockView:self didBeginWithPasscode:[NSString stringWithFormat:@"%@", @(touchedBtn.tag)]];
                }
            }
        }
        
        _trackedLocation = point;
        [self setNeedsDisplay];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    if (_selectedButtons.count > 0) {
        NSMutableString *passwd = [NSMutableString string];
        for (UIButton *btn in _selectedButtons) {
            [passwd appendString:[NSString stringWithFormat:@"%@,", @(btn.tag)]];
        }
        [passwd deleteCharactersInRange:NSMakeRange(passwd.length-1, 1)];
        
        if ([self.delegate respondsToSelector:@selector(lockView:didEndWithPasscode:)]) {
            [self.delegate lockView:self didEndWithPasscode:passwd];
        }
    }
    
    
    _trackedLocation = InvalidPoint;
    
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (UIButton *btn in _selectedButtons) {
            btn.selected = NO;
        }
        [self setNeedsDisplay];
        [_selectedButtons removeAllObjects];
        self.userInteractionEnabled = YES;
    });
    
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    if (_selectedButtons.count > 0) {
        NSMutableString *passwd = [NSMutableString string];
        for (UIButton *btn in _selectedButtons) {
            [passwd appendString:[NSString stringWithFormat:@"%@,", @(btn.tag)]];
        }
        [passwd deleteCharactersInRange:NSMakeRange(passwd.length-1, 1)];
        
        if ([self.delegate respondsToSelector:@selector(lockView:didCancelWithPasscode:)]) {
            [self.delegate lockView:self didCancelWithPasscode:passwd];
        }
    }
    
    _trackedLocation = InvalidPoint;
    
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (UIButton *btn in _selectedButtons) {
            btn.selected = NO;
        }
        [self setNeedsDisplay];
        [_selectedButtons removeAllObjects];
        self.userInteractionEnabled = YES;
    });
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
