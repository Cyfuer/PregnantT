//
//  UIView+Extension.m
//  ITTARefreshExample
//
//  Created by ITTA on 14-5-28.
//  Copyright (c) 2014年 ITTA. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setLine:(DirectionType)type {
    UIBezierPath *path = [UIBezierPath bezierPath];
    switch (type) {
        case top:
        {
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
        }
            break;
        case left:
        {
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
        }
            break;
        case bottom:
        {
            [path moveToPoint:CGPointMake(0, self.bounds.size.height)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
        }
            break;
        case right:
        {
            [path moveToPoint:CGPointMake(self.bounds.size.width, 0)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
        }
            break;
            
        default:
            break;
    }
    
    // 最后的闭合线是可以通过调用closePath方法来自动生成的，也可以调用-addLineToPoint:方法来添加
    //[path closePath];
    
    // 创建图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00].CGColor;
    shapeLayer.fillColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 1;
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)setDashLine:(DirectionType)type {
    UIBezierPath *path = [UIBezierPath bezierPath];
    switch (type) {
        case top:
        {
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
        }
            break;
        case left:
        {
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
        }
            break;
        case bottom:
        {
            [path moveToPoint:CGPointMake(0, self.bounds.size.height)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
        }
            break;
        case right:
        {
            [path moveToPoint:CGPointMake(self.bounds.size.width, 0)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
        }
            break;
            
        default:
            break;
    }
    
    // 最后的闭合线是可以通过调用closePath方法来自动生成的，也可以调用-addLineToPoint:方法来添加
    //[path closePath];
    
    // 创建图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00].CGColor;
    shapeLayer.fillColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00].CGColor;
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil]];
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 1;
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
}
@end
