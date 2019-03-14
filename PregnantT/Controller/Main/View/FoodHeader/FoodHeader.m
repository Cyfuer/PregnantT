//
//  FoodHeader.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/20.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "FoodHeader.h"
#import "UIColor+extra.h"

@implementation FoodHeader

+ (instancetype) loadView {
    return [[NSBundle mainBundle] loadNibNamed:@"FoodHeader" owner:self options:nil][0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.height >= kFoodHeader_MaxHeight) {
        self.gradientViewH.constant = self.height;
        
        if (!self.timer || ![self.timer isValid]) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:8 repeats:YES block:^(NSTimer * _Nonnull timer) {
                FoodHeaderCloundView *clound = [FoodHeaderCloundView cloundWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.8)];
                [self addSubview:clound];
            }];
        }
        
    } else {
        if ([self.timer isValid]) {
            [self.timer invalidate];
        }
    }
}

@end



@implementation FoodHeaderGradientView

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    layer.colors = @[(__bridge id)hexColor(@"A0A6F0").CGColor,
                    (__bridge id)hexColor(@"BEA2ED").CGColor,
                    (__bridge id)hexColor(@"F5BDBB").CGColor];
    layer.locations = @[@(0),
                       @(0.4),
                       @(1)];
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
}

#pragma mark - Setter
- (void)setColors:(NSArray *)colors {
    if (colors && colors.count) {
        // UIColor 转化为 CGColorRef
        NSMutableArray *refColors = [NSMutableArray array];
        for (UIColor *color in colors) {
            [refColors addObject:(__bridge id)color.CGColor];
        }
        
        _colors = (NSArray *)refColors;
        [self colorsAnimation:refColors];
    }
}

- (void)setLocations:(NSArray<NSNumber *> *)locations {
    if (locations && locations.count) {
        _locations = locations;
        [self locationsAnimation:locations];
    }
}

- (void)setStartPoint:(CGPoint)startPoint {
    _startPoint = startPoint;
    [self startPointAnimation:startPoint];
}

- (void)setEndPoint:(CGPoint)endPoint {
    _endPoint = endPoint;
    [self endPointAnimation:endPoint];
}

- (void)colorsAnimation:(NSArray *)colors {
    [self animationWityKey:@"colors" value:(id)colors];
}

- (void)locationsAnimation:(NSArray *)locations {
    [self animationWityKey:@"locations" value:(id)locations];
}

- (void)startPointAnimation:(CGPoint)startPoint {
    [self animationWityKey:@"startPoint" value:[NSValue valueWithCGPoint:startPoint]];
}

- (void)endPointAnimation:(CGPoint)endPoint {
    [self animationWityKey:@"endPoint" value:[NSValue valueWithCGPoint:endPoint]];
}

- (void)animationWityKey:(NSString *)keyPath value:(id)value {
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    
    CABasicAnimation *a =[CABasicAnimation animation];
    a.removedOnCompletion = NO;
    a.fillMode = kCAFillModeForwards;
    a.keyPath = keyPath;
    a.toValue = value;
    a.duration = 5;
    [layer addAnimation:a forKey:@"a"];
}

@end



@implementation FoodHeaderCloundView

+ (instancetype)cloundWithRect:(CGRect)rect {
    // 随机云朵
    int index = arc4random() % 8;
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"sky_cloud%d",index]];
    FoodHeaderCloundView *clound = [[FoodHeaderCloundView alloc] initWithImage:img];
    clound.alpha = 0;
    clound.layer.anchorPoint = CGPointMake(.5, .5);
    
    // 在固定区域内随机位置
    CGRect randomRect = CGRectMake( randomX(rect), randomY(rect), img.size.width, img.size.height);
    clound.frame = randomRect;
    clound.formerFrame = randomRect;
    
    // 开始平移动画
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        clound.alpha = 1;
    } completion:^(BOOL finished) {
        [clound moveAnimationInRect:rect];
    }];
    
    // 定时消失
    CGFloat time = arc4random() % 30 + 10;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            clound.alpha = 0;
        } completion:^(BOOL finished) {
            [clound removeFromSuperview];
        }];
    });
    
    return clound;
}

- (void)moveAnimationInRect:(CGRect)rect {
    
    // 新的中心点x、y
    CGFloat x = randomX(rect);
    CGFloat y = randomY(rect);
    
    // 刷新formerFrame
    CGRect r = self.formerFrame;
    r.origin.x = x - r.size.width/2;
    r.origin.y = y - r.size.height/2;
    self.formerFrame = r;
    
    [UIView animateWithDuration:40 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.center = CGPointMake(x, y);
    } completion:^(BOOL finished) {
//        [self moveAnimationInRect:rect];
    }];
}


CGFloat randomX(CGRect rect) {
    return rect.origin.x + arc4random() % (int)rect.size.width;
}

CGFloat randomY(CGRect rect) {
    return rect.origin.y + arc4random() % (int)rect.size.height;
}

@end
