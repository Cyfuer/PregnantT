//
//  LandscapeSkyView.h
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/6.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "LandscapeBaseView.h"


typedef NS_ENUM(NSInteger, LandscapeSkySunlightType) {
    kLandscapeSkySunlightTypeDaybread, // 天亮
    kLandscapeSkySunlightTypeSunrise, // 日出
    kLandscapeSkySunlightTypeMidday, // 日中
    kLandscapeSkySunlightTypeSunset, // 日落
    kLandscapeSkySunlightTypeNight // 天黑
};

@interface LandscapeSkyView : LandscapeBaseView

/**
 初始化

 @param frame frame
 @param horizon 水平线，确定水波的顶部
 @return LandscapeSkyView
 */
- (id)initWithFrame:(CGRect)frame horizon:(CGFloat)horizon;

@end

