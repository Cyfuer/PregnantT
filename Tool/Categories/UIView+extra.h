//
//  UIView+extra.h
//  LoveClass
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, SideType) {
    UIViewSideTop     = 1 << 0,
    UIViewSideLeft    = 1 << 1,
    UIViewSideBottom  = 1 << 2,
    UIViewSideRight   = 1 << 3,
    UIViewSideAll = ~0UL
};

@interface UIView (extra)<UIGestureRecognizerDelegate>

// 为view某个方向的边描线
- (void)setLine:(SideType)types Color:(UIColor *)color;

// 为view某个方向的边描虚线
- (void)setDashLine:(SideType)types Color:(UIColor *)color;

// 添加点击即关闭键盘的点击手势
- (void)addTargetForEndEdit;

@end
