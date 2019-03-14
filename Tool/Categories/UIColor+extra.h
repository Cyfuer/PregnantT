//
//  UIColor+extra.h
//  ZZMCode
//
//  Created by Cyfuer on 16/7/6.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

#define hexColor(hex) [UIColor colorWithHexString:hex]

@interface UIColor (extra)

//-------字符转颜色对象-------//
+ (UIColor *) colorWithHexString:(NSString *)hex;


//-------图片-------//
+ (UIImage *)createImage:(UIColor *)color;

@end
