//
//  AppUtils.m
//  LoveClass
//
//  Created by Cyfuer on 16/9/24.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "AppUtils.h"

BOOL isEmpty(NSString *string) {
    if ([string isKindOfClass:[NSString class]] || [string isKindOfClass:[NSNull class]]) {
        return (string == nil) || [string isEqual:[NSNull null]] || (string.length == 0) ;
    } else {
        return YES;
    }
}

NSString *null(NSString *displayStr, NSString *defaultStr) {
    if (isEmpty(displayStr)) {
        return defaultStr;
    } else {
        return displayStr;
    }
}

NSString *nulls(NSString *displayStr) {
    if (isEmpty(displayStr)) {
        return @"";
    } else {
        return displayStr;
    }
}


NSString *matchStr(NSString *str,...) {
    // 根据可变参数获取数组
    NSMutableString *mutableStr = [NSMutableString string];
    if (str && ![str isEqual:[NSNull null]]) {
        id eachObject;
        va_list argumentList;
        
        [mutableStr appendString:null(str, @"")];
        va_start(argumentList, str);
        while ((eachObject = va_arg(argumentList, id))) {
            [mutableStr appendString:null(eachObject, @"")];
        }
        va_end(argumentList);
    }
    
    return (NSString *)mutableStr;
}

NSURL *url(NSString *urlStr) {
    if (urlStr == nil || urlStr == NULL || [urlStr isEqual:[NSNull null]]) {
        return nil;
    }
    else {
        return [NSURL URLWithString:urlStr];
    }
}

NSObject *o_nil(NSObject *o,NSString *c) {
    if (o) {
        return o;
    } else {
        return [[NSClassFromString(c) alloc] init];
    }
}

NSString *timeStr(NSString *timestamp) {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:confromTimesp];
}

NSString *timeStrByDate(NSDate *date,NSString *format) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

@implementation AppUtils

@end
