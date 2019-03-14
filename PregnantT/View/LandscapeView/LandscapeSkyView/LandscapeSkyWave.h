//
//  LandscapeSkyWave.h
//  PregnantT
//  波浪
//  Created by iflashbuy_dev on 2016/12/8.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "LandscapeBaseView.h"

#define kLandscapeVirtualWind_DEFAULT_SPEED 0.1;
#define kLandscapeVirtualWind_DEFAULT_PEAK  4.0
#define kLandscapeVirtualWind_DEFAULT_PERIOD 1.4
#define kLandscapeVirtualWind_DEFAULT_COLOR [UIColor colorWithRed:223/255.0 green:83/255.0 blue:64/255.0 alpha:0.5]

typedef NS_ENUM(NSInteger ,mCurveType) {
    mCurveTypeSin, // 正选
    mCurveTypeCos  // 余弦
};

@interface LandscapeSkyWave : LandscapeBaseThing

@property (nonatomic, assign) mCurveType curveType;
@property (nonatomic, assign) CGFloat speed;  // 水波横向移动的速度 DEFAULT:0.1
@property (nonatomic, assign) CGFloat peak;   // 峰值:水波的纵向高度 DEFAULT:10.0
@property (nonatomic, assign) CGFloat period; // 周期数:一定宽度内水波的周期个数 DEFAULT:1.4

@property (nonatomic, strong) UIColor *firstWaveColor; // 第一个水波的背景色
@property (nonatomic, strong) UIColor *secondWaveColor; // 第二个水波的背景色

- (void)startMove;
- (void)stopMove;

@end
