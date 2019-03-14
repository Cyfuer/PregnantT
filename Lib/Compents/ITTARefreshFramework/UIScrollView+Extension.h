//
//  UIScrollView+Extension.h
//  ITTARefreshExample
//
//  Created by ITTA on 14-5-28.
//  Copyright (c) 2014年 ITTA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Extension)
@property (assign, nonatomic) CGFloat contentInsetTop;
@property (assign, nonatomic) CGFloat contentInsetBottom;
@property (assign, nonatomic) CGFloat contentInsetLeft;
@property (assign, nonatomic) CGFloat contentInsetRight;

@property (assign, nonatomic) CGFloat contentOffsetX;
@property (assign, nonatomic) CGFloat contentOffsetY;

@property (assign, nonatomic) CGFloat contentSizeWidth;
@property (assign, nonatomic) CGFloat contentSizeHeight;
@end
