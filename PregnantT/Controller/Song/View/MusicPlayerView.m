//
//  MusicPlayerView.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/29.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "MusicPlayerView.h"
#import "UIColor+extra.h"

@interface MusicPlayerView ()

@property (strong, nonatomic) UIView *ringView;


@property (strong, nonatomic) CATransformLayer *voiceLayer; // 音量条

@property (strong, nonatomic) CALayer *progressPointLayer; // 播放进度的小圆点

@end


@implementation MusicPlayerView

- (void)drawRect:(CGRect)rect {
    
}

- (void)setupRingView:(CGRect)rect {
    
    // 圆环的半径
    CGFloat r0 = rect.size.width / 375 * 240 / 2; // 根据屏幕宽度按375/240计算所得
    
    CGFloat r1 = r0 - 3;
    
    CGFloat r2 = r1 - 0.5;
    
    
    
    
}



#pragma mark - Getter
- (UIView *)ringView {
//    if (!_ringView) {
//        _ringView = [UIView alloc] initWithFrame:
//    }
    return nil;
}

@end





@interface SubMusicPlayerRingView ()

@property (strong, nonatomic) CALayer *grayLayer;// 灰边圆环
@property (strong, nonatomic) CAGradientLayer *gradientLayer;// 渐变色圆环

@end

@implementation SubMusicPlayerRingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.width / 2;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat r = rect.size.width / 2;
    // 灰边圆环的半径
    CGFloat gray_r = r - 3;
    // 渐变色圆环的半径
    CGFloat gradient_r = gray_r - 0.5;
    
    
    // 灰色边框环
    _grayLayer = [[CALayer alloc] init];
    _grayLayer.borderColor = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:0.24].CGColor;
    _grayLayer.bounds = CGRectMake(0, 0, gray_r, gray_r);
    _grayLayer.position = self.center;
    _grayLayer.cornerRadius = gray_r;
    _grayLayer.borderWidth = 0.5;
    
    // 渐变色环
    _gradientLayer = [[CAGradientLayer alloc] init];
    _gradientLayer.bounds = CGRectMake(0, 0, gradient_r, gradient_r);
    _gradientLayer.position = self.center;
    _gradientLayer.cornerRadius = gradient_r;
    _gradientLayer.startPoint = CGPointMake(0.8, 0);
    _gradientLayer.endPoint = CGPointMake(0, 0.9);
    _gradientLayer.colors = @[(__bridge id)hexColor(@"FFFFFF").CGColor,(__bridge id)hexColor(@"A8ABD3").CGColor];
    
    [self.layer addSublayer:_grayLayer];
    [self.layer addSublayer:_gradientLayer];
}

#pragma mark - Setter
- (void)setCustomColors:(NSArray *)customColors {
    if (customColors && customColors.count) {
        NSMutableArray *colorsArray = [NSMutableArray array];
        for (UIColor *color in customColors) {
            [colorsArray addObject:(__bridge id)color.CGColor];
        }
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:5];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:@"easeInEaseOut"]];
        _gradientLayer.colors = colorsArray;
        [CATransaction commit];
    }
}

- (void)setCustomLocations:(NSArray<NSNumber *> *)customLocations {
    [CATransaction begin];
    [CATransaction setAnimationDuration:5];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:@"easeInEaseOut"]];
    _gradientLayer.locations = customLocations;
    [CATransaction commit];
}

@end






@interface SubMusicPlayerVoiceView ()

@property (strong, nonatomic) CATransformLayer *anchorLayer;// 控制所有子图层的锚点

@end

@implementation SubMusicPlayerVoiceView



@end
