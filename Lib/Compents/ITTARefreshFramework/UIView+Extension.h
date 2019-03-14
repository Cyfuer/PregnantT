//
//  UIView+Extension.h
//  ITTARefreshExample
//
//  Created by ITTA on 14-5-28.
//  Copyright (c) 2014年 ITTA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, DirectionType) {
    top = 0,
    left,
    bottom,
    right
};

@interface UIView (Extension)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

// 为view某个方向的边描线
- (void)setLine:(DirectionType)type;

// 为view某个方向的边描虚线
- (void)setDashLine:(DirectionType)type;
@end
