//
//  LandscapeColor.h
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/6.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LandscapeColor : NSObject

@property (strong, nonatomic) UIColor *color;// 颜色
@property (assign, nonatomic) CGFloat location;// 渐变色所在位置，以单位坐标系定义，值在0至1之间的

+ (id)instanceWithColor:(UIColor *)color location:(CGFloat)location;

@end
