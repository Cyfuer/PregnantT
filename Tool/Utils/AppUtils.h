//
//  AppUtils.h
//  LoveClass
//
//  Created by Cyfuer on 16/9/24.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  判断字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return string 为空,返回 YES
 string 不为空,返回 NO
 */
BOOL isEmpty(NSString *string);


/**
 *  字符串处理
 *
 *  @param displayStr 要显示的字符串
 *  @param defaultStr 默认的字符串
 *
 *  @return displayStr 为空，返回 defaultStr
 displayStr 不为空，返回 displayStr
 */
NSString *null(NSString *displayStr, NSString *defaultStr);


/**
 *  字符串处理
 *
 *  @param displayStr 要显示的字符串
 *
 *  @return displayStr 为空，返回 空字符串
 displayStr 不为空，返回 displayStr
 */
NSString *nulls(NSString *displayStr);

/**
 *  拼接字符串
 *
 *  @param str 字符串
 *
 *  @return 拼接起来的字符串
 */
NSString *matchStr(NSString *str,...);


/**
 *  把字符串转换成NSURL对象
 */
NSURL *url(NSString *urlStr);


/**
 *  空对象处理
 *
 *  @param o 要处理的对象
 *  @param c 对象所属类名
 *
 *  @return o 为空，返回类为c的空对象
 o 不为空，返回 o
 */
NSObject *o_nil(NSObject *o,NSString *c);


/**
 *  时间戳转时间
 *
 *  @param timestamp 要处理的时间戳（13位）
 *
 *  @return 时间字符串
 o 不为空，返回 o
 */
NSString *timeStr(NSString *timestamp);


/**
 *  NSDate转时间
 *
 *  @param date 要处理的NSDate
 *  @param format 要转成的字符格式 yyyy-MM-dd HH:mm:ss zzz
 *
 *  @return 时间字符串
 o 不为空，返回 o
 */
NSString *timeStrByDate(NSDate *date,NSString *format);



@interface AppUtils : NSObject



@end
