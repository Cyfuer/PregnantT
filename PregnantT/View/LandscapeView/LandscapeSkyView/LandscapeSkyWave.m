//
//  LandscapeSkyWave.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/8.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "LandscapeSkyWave.h"

@interface LandscapeSkyWave () {
    CGFloat height;// 水波水平线的高度,开始动画从0增至最大，结束后归0
    CGFloat width;// 水波的宽度
    CGFloat waterLevel; // 水位
    CGFloat offset;// 每次刷新水波的水平位移
    CAShapeLayer *windLayer;
    CADisplayLink *link;
}
@property (strong, nonatomic) CAShapeLayer *firstWaveLayer;
@property (strong, nonatomic) CAShapeLayer *secondWaveLayer;

@end

@implementation LandscapeSkyWave

#pragma mark - Intializer
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        width = frame.size.width;
        height = frame.size.height;
        waterLevel = frame.size.height / 3;
        _speed = kLandscapeVirtualWind_DEFAULT_SPEED;
        _peak = kLandscapeVirtualWind_DEFAULT_PEAK;
        _period = kLandscapeVirtualWind_DEFAULT_PERIOD;
        _firstWaveColor = kLandscapeVirtualWind_DEFAULT_COLOR;
        _secondWaveColor = kLandscapeVirtualWind_DEFAULT_COLOR;
    }
    return self;
}


#pragma mark - Private
- (void)startMove {
    
    if (link == nil) {
        
        link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stopMove {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [link invalidate];
        link = nil;
    });
}

#pragma mark @ 定时器事件
- (void)displayLinkAction {
    offset -= self.speed;
    
    // 正弦曲线
    CGMutablePathRef sinPath = [self pathWithCurveType:mCurveTypeSin];
    self.firstWaveLayer.path = sinPath;
    CGPathRelease(sinPath);
    
    // 余弦曲线
    CGMutablePathRef cosPath = [self pathWithCurveType:mCurveTypeCos];
    self.secondWaveLayer.path = cosPath;
    CGPathRelease(cosPath);
}

#pragma mark @ 通过曲线类型获得对应的曲线路径
- (CGMutablePathRef)pathWithCurveType:(mCurveType)curveType {
    
    if (waterLevel > kLandscapeVirtualWind_DEFAULT_PEAK) {
        waterLevel -= 1;
    }
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathMoveToPoint(mutablePath, nil, -1, height);
    CGFloat y;
    for (CGFloat x = 0.0f; x <= width; x++) {
        switch (curveType) {
            case 0:
                y = self.peak * sin(self.period * M_PI / width * x + offset) + waterLevel;
                break;
            case 1:
                y = self.peak * cos(self.period * M_PI / width * x + offset) + waterLevel;
                break;
                
            default:
                break;
        }
        CGPathAddLineToPoint(mutablePath, nil, x, y);
    }
    CGPathAddLineToPoint(mutablePath, nil, width, height);
    CGPathAddLineToPoint(mutablePath, nil, 0, height);
    CGPathCloseSubpath(mutablePath);
    return mutablePath;
}

#pragma mark - Setter

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    width = frame.size.width;
    height = frame.size.height;
    waterLevel = frame.size.height / 3;
}

- (void)setSpeed:(CGFloat)speed {
    NSAssert(speed >= 0, @"水波纹横向移动速度不得小于0!");
    _speed = speed;
}

- (void)setPeak:(CGFloat)peak {
    NSAssert(peak >= 0, @"水波纹峰值不得小于0!");
    _peak = peak;
}

- (void)setPeriod:(CGFloat)period {
    NSAssert(period > 0, @"水波纹周期数必须大于0!");
    _period = period;
}


#pragma mark - Getter
- (CAShapeLayer *)firstWaveLayer {
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = _firstWaveColor ? _firstWaveColor.CGColor : kLandscapeVirtualWind_DEFAULT_COLOR.CGColor;
        _firstWaveLayer.shadowOffset = CGSizeMake(0, -3);
        _firstWaveLayer.shadowOpacity = 0.4;
        _firstWaveLayer.shadowColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_firstWaveLayer];
    }
    return _firstWaveLayer;
}

- (CAShapeLayer *)secondWaveLayer {
    if (!_secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.fillColor = _secondWaveColor ? _secondWaveColor.CGColor : kLandscapeVirtualWind_DEFAULT_COLOR.CGColor;
        _secondWaveLayer.shadowOffset = CGSizeMake(0, -3);
        _secondWaveLayer.shadowOpacity = 0.4;
        _secondWaveLayer.shadowColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_secondWaveLayer];
    }
    return _secondWaveLayer;
}

@end
