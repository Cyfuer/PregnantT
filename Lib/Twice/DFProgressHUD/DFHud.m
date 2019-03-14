//
//  DFHud.m
//  iFlashBuy_6
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 width. All rights reserved.
//

#import "DFHud.h"

@interface DFHud () <UIAlertViewDelegate>

@end

@implementation DFHud

#pragma mark - 活动指示器

+ (void)showActivityHud:(UIView *)view
                  delay:(CGFloat)delayTime
                    msg:(NSString *)msg {
    [[DFProgressHUD shareInstance] showActivityIndicator:delayTime Title:msg view:view];
}

+ (void)showActivityHud:(CGFloat)delayTime
                          msg:(NSString *)msg {
    [[DFProgressHUD shareInstance] showActivityIndicator:delayTime Title:msg view:nil];
}

+ (void)showActivityHud:(NSString *)msg {
    [[DFProgressHUD shareInstance] showActivityIndicator:0 Title:msg view:nil];
}

+ (void)showActivityHud {
    [[DFProgressHUD shareInstance] showActivityIndicator:0 Title:@"" view:nil];
}

#pragma mark - 文本提示框

+ (void)showMessageHud:(UIView *)view
                 delay:(CGFloat)delayTime
                   msg:(NSString *)msg {
    [[DFProgressHUD shareInstance] showTextActivityIndicator:delayTime Title:msg view:view];
}

+ (void)showMessageHud:(CGFloat)delayTime
                   msg:(NSString *)msg {
    [[DFProgressHUD shareInstance] showTextActivityIndicator:delayTime Title:msg view:nil];
}

+ (void)showMessageHud:(NSString *)msg {
    [[DFProgressHUD shareInstance] showTextActivityIndicator:textActivityIndicatorShowTime Title:msg view:nil];
}

#pragma mark - 系统提示框

+ (void)showAlertView:(NSString *)title
                  msg:(NSString *)msg
      completionBlock:(void (^)(NSUInteger buttonIndex,DFAlertView *alertView))block
       cancelBtnTitle:(NSString *)cancelBtnTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    // 根据可变参数获取数组
    NSMutableArray *otherBtnArr = [NSMutableArray array];
    id eachObject;
    va_list argumentList;
    if (otherButtonTitles) {
        [otherBtnArr addObject:otherButtonTitles];
        va_start(argumentList, otherButtonTitles);
        while ((eachObject = va_arg(argumentList, id))) {
            [otherBtnArr addObject:eachObject];
        }
        va_end(argumentList);
    }
    
    [DFAlertView showAlertWithTitle:title message:msg completionBlock:block cancelButtonTitle:cancelBtnTitle otherButtonTitles:otherBtnArr];
}

+ (void)showAlertView:(NSString *)msg
      completionBlock:(void (^)(NSUInteger buttonIndex,DFAlertView *alertView))block
       cancelBtnTitle:(NSString *)cancelBtnTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    // 根据可变参数获取数组
    NSMutableArray *otherBtnArr = [NSMutableArray array];
    id eachObject;
    va_list argumentList;
    if (otherButtonTitles) {
        [otherBtnArr addObject:otherButtonTitles];
        va_start(argumentList, otherButtonTitles);
        while ((eachObject = va_arg(argumentList, id))) {
            [otherBtnArr addObject:eachObject];
        }
        va_end(argumentList);
    }
    
    [DFAlertView showAlertWithTitle:@"温馨提示" message:msg completionBlock:block cancelButtonTitle:cancelBtnTitle otherButtonTitles:otherBtnArr];
}

+ (void)showAlertView:(NSString *)msg
      completionBlock:(void (^)(NSUInteger buttonIndex,DFAlertView *alertView))block
       cancelBtnTitle:(NSString *)cancelBtnTitle {

    [DFAlertView showAlertWithTitle:@"温馨提示" message:msg completionBlock:block cancelButtonTitle:cancelBtnTitle otherButtonTitles:nil];
}

+ (void)showAlertView:(NSString *)msg
       cancelBtnTitle:(NSString *)cancelBtnTitle {
    [DFAlertView showAlertWithTitle:@"温馨提示" message:msg completionBlock:nil cancelButtonTitle:cancelBtnTitle otherButtonTitles:nil];
}

+ (void)showAlertView:(NSString *)msg {
    [DFAlertView showAlertWithTitle:@"温馨提示" message:msg completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}



+ (void)hide {
    [[DFProgressHUD shareInstance] hideActivityIndicator];
}

@end
