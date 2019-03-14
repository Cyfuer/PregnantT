//
//  LandscapeSkyBackground.h
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/13.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "LandscapeBaseView.h"
#import "LandscapeSkyView.h"

@interface LandscapeSkyBackground : LandscapeBaseThing

@property (assign, nonatomic) LandscapeSkySunlightType type;

- (instancetype)initWithFrame:(CGRect)frame type:(LandscapeSkySunlightType)type;

@end
