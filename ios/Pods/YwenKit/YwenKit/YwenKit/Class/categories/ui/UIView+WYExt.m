//
//  UIView+WYExt.m
//  xebest
//
//  Created by ywen on 15/3/11.
//  Copyright (c) 2015年 xianyi. All rights reserved.
//

#import "UIView+WYExt.h"
#import "UIColor+WYExt.h"

@implementation UIView (WYExt)

-(void) WY_MakeCorn:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

-(CAShapeLayer *) makeBorderLayer: (WyDirection) direction borderColor: (UIColor *) color lineWidth: (CGFloat) width {
    UIBezierPath *bezierPath;
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    switch (direction) {
        case Top:
            bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width, width)];
            layer.frame = CGRectMake(0, 0, self.bounds.size.width, width);
            break;
            
        case Right:
            bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, self.bounds.size.height)];
            layer.frame = CGRectMake(self.bounds.size.width - width, 0, width, self.bounds.size.height);
            break;
            
        case Bottom:
            bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width, width)];
            layer.frame = CGRectMake(0, self.bounds.size.height - width, self.bounds.size.width, width);
            break;
            
        case Left:
            bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, self.bounds.size.height)];
            layer.frame = CGRectMake(0, 0, width, self.bounds.size.height);
            break;
            
        default:
            return nil;
            break;
    }
    
    layer.path = bezierPath.CGPath;
    layer.fillColor = color.CGColor;
    return layer;
}

-(void)WY_MakeBorder:(WyDirection)direction borderColor:(UIColor *)color lineWidth:(CGFloat)width {
    NSUInteger origin = (NSUInteger) direction;
    NSUInteger mask = 0b0001;
    for (int i=0; i<4; i++) {
        if (origin & mask) {
            [self.layer addSublayer:[self makeBorderLayer:mask borderColor:color lineWidth:width]];
        }
        mask = mask << 1;
    }
}

-(void)WY_MakeCircleBorder:(CGFloat)width color:(UIColor *)color {
    CGFloat radius = self.bounds.size.width / 2;
    [self WY_MakeCorn:radius];
    CAShapeLayer *circle = [[CAShapeLayer alloc] init];
    circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = color.CGColor;
    circle.lineWidth = width;
    [self.layer addSublayer:circle];
}

-(void)WY_SetBorder:(NSInteger)borderColor width:(CGFloat)borderWidth {
    self.layer.borderColor = [UIColor WY_ColorWithHex:borderColor].CGColor;
    self.layer.borderWidth = borderWidth;
}

@end
