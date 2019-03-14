//
//  LandscapeSkyView.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/6.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "LandscapeSkyView.h"
#import "LandscapeSkyWave.h"
#import "LandscapeSkyWindMill.h"
#import "LandscapeSkyBackground.h"

@interface LandscapeSkyView () {
    CGFloat horiz;
    CGFloat h;
    CGFloat w;
}

@property (strong, nonatomic) LandscapeSkyWave *waveView;
@property (strong, nonatomic) LandscapeSkyWindMill *windMillView;
@property (strong, nonatomic) LandscapeSkyBackground *bgView;

@end

@implementation LandscapeSkyView

- (id)initWithFrame:(CGRect)frame horizon:(CGFloat)horizon {
    self = [super initWithFrame:frame];
    if (self) {
        h = frame.size.height;
        w = frame.size.width;
        horiz = horizon;
        
        [self addSubview:self.bgView];
        [self addSubview:self.windMillView];
        [self addSubview:self.waveView];
    }
    return self;
}

#pragma mark - Getter
- (LandscapeSkyWave *)waveView {
    if (!_waveView) {
        _waveView = [[LandscapeSkyWave alloc] initWithFrame:CGRectMake(0, horiz, w, h - horiz)];
        [_waveView startMove];
    }
    return _waveView;
}

- (LandscapeSkyWindMill *)windMillView {
    if (!_windMillView) {
        _windMillView = [[LandscapeSkyWindMill alloc] initWithFrame:CGRectMake(w - kLandscapeSkyWindMill_WIDTH, horiz - kLandscapeSkyWindMill_HEIGHT + 10, 0, 0)];
        
    }
    return _windMillView;
}

- (LandscapeSkyBackground *)bgView {
    if (!_bgView) {
        CGRect rect = CGRectMake(0, 0, w, horiz + 20);
        LandscapeSkySunlightType type = kLandscapeSkySunlightTypeSunrise;
        _bgView = [[LandscapeSkyBackground alloc] initWithFrame:rect type:type];
    }
    return _bgView;
}

@end

