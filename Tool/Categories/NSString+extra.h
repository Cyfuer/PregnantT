//
//  NSString+extra.h
//  LoveClass
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (extra)

/**
 *  手机号有效性
 */
- (BOOL)isMobileNumber;

/**
 *  邮箱的有效性
 */
- (BOOL)isEmailAddress;


/**
 *  MD5
 */
- (NSString *) stringFromMD5;

/**
 *  JSON
 */
- (NSDictionary *)dictFromJson;

@end
