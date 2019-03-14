//
//  NSString+extra.m
//  LoveClass
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "NSString+extra.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (extra)

//手机号有效性
- (BOOL)isMobileNumber{
    /**
     *  手机号以13、15、18、170开头，8个 \d 数字字符
     *  小灵通 区号：010,020,021,022,023,024,025,027,028,029 还有未设置的新区号xxx
     */
    NSString *mobileNoRegex = @"^1((3\\d|5[0-35-9]|8[025-9])\\d|70[059])\\d{7}$";//除4以外的所有个位整数，不能使用[^4,\\d]匹配，这里是否iOS Bug?
    NSString *phsRegex =@"^0(10|2[0-57-9]|\\d{3})\\d{7,8}$";
    
    BOOL ret = [self isValidateByRegex:mobileNoRegex];
    BOOL ret1 = [self isValidateByRegex:phsRegex];
    
    return (ret || ret1);
}

//邮箱
- (BOOL)isEmailAddress{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}

- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

// MD5
- (NSString *)stringFromMD5 {
    // 需要导入<CommonCrypto/CommonDigest.h>
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (int)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

// JSON
- (NSDictionary *)dictFromJson {
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


@end
