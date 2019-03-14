//
//  UIView+extra.m
//  LoveClass
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "UIView+extra.h"

@implementation UIView (extra)

- (void)setLine:(SideType)types Color:(UIColor *)color {
    [self addLayerWithSides:types byColor:color isDash:NO];
}

- (void)setDashLine:(SideType)types Color:(UIColor *)color {
    [self addLayerWithSides:types byColor:color isDash:YES];
}

- (void)addLayerWithSides:(SideType)sides byColor:(UIColor *)color isDash:(BOOL)isDash {
    if (sides & UIViewSideTop) {
        CAShapeLayer *layer = [self shapeLayerWithSide:UIViewSideTop byColor:color isDash:isDash];
        [self.layer addSublayer:layer];
    }
    
    if (sides & UIViewSideLeft) {
        CAShapeLayer *layer = [self shapeLayerWithSide:UIViewSideLeft byColor:color isDash:isDash];
        [self.layer addSublayer:layer];
    }
    
    if (sides & UIViewSideBottom) {
        CAShapeLayer *layer = [self shapeLayerWithSide:UIViewSideBottom byColor:color isDash:isDash];
        [self.layer addSublayer:layer];
    }
    
    if (sides & UIViewSideRight) {
        CAShapeLayer *layer = [self shapeLayerWithSide:UIViewSideRight byColor:color isDash:isDash];
        [self.layer addSublayer:layer];
    }
}

- (CAShapeLayer *)shapeLayerWithSide:(SideType)side byColor:(UIColor *)color isDash:(BOOL)isDash {
    UIBezierPath *path = [UIBezierPath bezierPath];
    switch (side) {
        case UIViewSideTop:
        {
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
        }
            break;
        case UIViewSideLeft:
        {
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
        }
            break;
        case UIViewSideBottom:
        {
            [path moveToPoint:CGPointMake(0, self.bounds.size.height)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
        }
            break;
        case UIViewSideRight:
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
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = color.CGColor;
    //  设置线宽，线间距
    if (isDash) {
        [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil]];
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
    }
    
    shapeLayer.lineWidth = .5;
    shapeLayer.path = path.CGPath;
    
    return shapeLayer;
}


- (void)addTargetForEndEdit {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSuperMainView:)];
    tapGesture.numberOfTouchesRequired = 1;
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
}

- (void)tapSuperMainView:(UITapGestureRecognizer *)gesture {
    [[[UIApplication sharedApplication].delegate window] endEditing:YES];
}

@end
