//
//  LandscapeColor.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/6.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "LandscapeColor.h"

@implementation LandscapeColor

+ (id)instanceWithColor:(UIColor *)color location:(CGFloat)location {
    LandscapeColor *c = [[LandscapeColor alloc] init];
    c.color = color;
    c.location = location;
    return c;
}

@end
