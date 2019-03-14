//
//  LandscapeSkyBackground.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/13.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "LandscapeSkyBackground.h"

@interface LandscapeSkyBackground () {
    NSInteger keyNumber;//通过该值得自增生成每次都不同的key
}

@end

@implementation LandscapeSkyBackground

#pragma mark - Initialize
+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame type:(LandscapeSkySunlightType)type {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithType:type];
    }
    return self;
}

- (void)setupWithType:(LandscapeSkySunlightType)type {
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    layer.locations = @[@(0),@(0.4),@(1)];
    layer.colors = cgcolors(typeColors(type));
    
    _type = type;
}


#pragma mark - Private


/**
 获取颜色

 @param hex 十六进制色值
 @return UIColor
 */
UIColor *hexColor(NSString *hex) {
    if ((hex.length == 0)||(hex == nil))
    {
        return nil;
    }
    
    if ( [hex hasPrefix:@"#"] )
    {
        hex = [hex substringWithRange:NSMakeRange(1, hex.length - 1)];
    }
    
    unsigned int red, green, blue;
    
    NSRange range;
    
    range.length =2;
    
    range.location =0;
    
    [[NSScanner scannerWithString:[hex substringWithRange:range]]scanHexInt:&red];
    
    range.location =2;
    
    [[NSScanner scannerWithString:[hex substringWithRange:range]]scanHexInt:&green];
    
    range.location =4;
    
    [[NSScanner scannerWithString:[hex substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}


/**
 获取CGColorRef颜色数组

 @param array 十六进制色值数组
 @return 颜色数组
 */
NSArray *cgcolors(NSArray <NSString *>*array) {
    NSMutableArray *cgcolors = [NSMutableArray array];
    if (array && array.count) {
        for (NSString *hex in array) {
            UIColor *color = hexColor(hex);
            if (color) {
                [cgcolors addObject:(__bridge id)color.CGColor];
            }
        }
        
        if (cgcolors) {
            return cgcolors;
        }
    }
    return nil;
    
}


/**
 获取改变图层渐变色的动画

 @param array 渐变色的十六进制色值数组
 @return CABasicAnimation
 */
CABasicAnimation *layerColorsAnimation(NSArray <NSString *>*array) {
    if (array && array.count) {
        CABasicAnimation *a =[CABasicAnimation animation];
        a.removedOnCompletion = NO;
        a.fillMode = kCAFillModeForwards;
        a.keyPath = @"colors";
        a.toValue = cgcolors(array);
        a.duration = 20;
        return a;
    } else {
        return nil;
    }
}


/**
 获取改变图层渐变色的动画组

 @param array 渐变色的十六进制色值二维数组
 @return CAAnimationGroup
 */
/*
CAAnimationGroup *layerColorsAnimationGroup(NSArray <NSArray *>*array) {
    if (array && array.count) {
        NSMutableArray *animations = [NSMutableArray array];
        for (NSArray *colors in array) {
            if (layerColorsAnimation(colors)) {
                [animations addObject:layerColorsAnimation(colors)];
            }
        }
        if (animations && animations.count) {
            CAAnimationGroup *group = [CAAnimationGroup animation];
            group.animations = (NSArray *)animations;
            group.duration = animations.count * 10;
            return group;
        }
        return nil;
    }
    return nil;
}*/

NSArray *typeColors(LandscapeSkySunlightType type) {
    switch (type) {
        case kLandscapeSkySunlightTypeDaybread: {
            return @[@"687BE8",@"8794F3",@"CFD0F6"];
        }
            break;
            
        case kLandscapeSkySunlightTypeSunrise:{
            return @[@"A0A6F0",@"BEA2ED",@"F5BDBB"];
        }
            
            break;
            
        case kLandscapeSkySunlightTypeMidday:{
            return @[@"BDEAFF",@"97E0FE",@"82DCFF"];
        }
            
            break;
            
        case kLandscapeSkySunlightTypeSunset:{
            return @[@"FADCAF",@"E3A675",@"F08251"];
        }
            
            break;
            
            
        case kLandscapeSkySunlightTypeNight:{
            return @[@"696DE1",@"7F82FA",@"8F75A8"];
        }
            
            break;
            
        default: {
            return @[@"A0A6F0",@"BEA2ED",@"F5BDBB"];
        }
            break;
    }
}

#pragma mark - Setter

- (void)setType:(LandscapeSkySunlightType)type {
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    NSString *key = [NSString stringWithFormat:@"key%ld",keyNumber + 1];
    [layer addAnimation:layerColorsAnimation(typeColors(type)) forKey:key];
    
    _type = type;
}

@end
