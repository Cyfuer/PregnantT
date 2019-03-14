//
//  UIColor+extra.m
//  ZZMCode
//
//  Created by Cyfuer on 16/7/6.
//  Copyright © 2016年 code. All rights reserved.
//

#import "UIColor+extra.h"

@implementation UIColor (extra)

#pragma mark - -- 字符转颜色对象
+ (UIColor *) colorWithHexString:(NSString *)hex
{
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



#pragma mark - -- 图片
+ (UIImage *)createImage:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
