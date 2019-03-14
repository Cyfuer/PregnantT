//
//  DFHud.h
//  iFlashBuy_6
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 width. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFAlertView.h"
#import "DFProgressHUD.h"


@interface DFHud : NSObject

#pragma mark - 活动指示器

+ (void)showActivityHud:(UIView *)view
                  delay:(CGFloat)delayTime
                    msg:(NSString *)msg;

+ (void)showActivityHud:(CGFloat)delayTime
                          msg:(NSString *)msg;

+ (void)showActivityHud:(NSString *)msg;

+ (void)showActivityHud;

#pragma mark - 文本提示框

+ (void)showMessageHud:(UIView *)view
                 delay:(CGFloat)delayTime
                   msg:(NSString *)msg;

+ (void)showMessageHud:(CGFloat)delayTime
                 msg:(NSString *)msg;

+ (void)showMessageHud:(NSString *)msg;

#pragma mark - 系统提示框

+ (void)showAlertView:(NSString *)title
                  msg:(NSString *)msg
      completionBlock:(void (^)(NSUInteger buttonIndex,DFAlertView *alertView))block
       cancelBtnTitle:(NSString *)cancelBtnTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ...;

+ (void)showAlertView:(NSString *)msg
      completionBlock:(void (^)(NSUInteger buttonIndex,DFAlertView *alertView))block
       cancelBtnTitle:(NSString *)cancelBtnTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ...;

+ (void)showAlertView:(NSString *)msg
      completionBlock:(void (^)(NSUInteger buttonIndex,DFAlertView *alertView))block
       cancelBtnTitle:(NSString *)cancelBtnTitle;

+ (void)showAlertView:(NSString *)msg
       cancelBtnTitle:(NSString *)cancelBtnTitle;

+ (void)showAlertView:(NSString *)msg;



+ (void)hide;

@end
