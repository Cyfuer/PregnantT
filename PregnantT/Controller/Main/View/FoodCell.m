//
//  FoodCell.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/16.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "FoodCell.h"

@implementation FoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.cornerRadius = 4;
    self.contentView.clipsToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 确保获取正确的frame
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    [self layoutBottomView];
}

- (void)layoutBottomView {
    
    // 添加有弧度的视图
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    self.shapeLayer.path = [self calculatePathWithPoint:CGPointMake(self.bottomView.width / 2.f, 10)].CGPath;
    [self.bottomView.layer addSublayer:self.shapeLayer];
}

- (UIBezierPath *)calculatePathWithPoint:(CGPoint)point {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, self.bottomView.height)];
    [path addLineToPoint:CGPointMake(self.bottomView.width, self.bottomView.height)];
    [path addLineToPoint:CGPointMake(self.bottomView.width, 0)];
    [path addQuadCurveToPoint:CGPointMake(0, 0)
                 controlPoint:point];
    
    return path;
}




@end
