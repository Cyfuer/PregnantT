//
//  DFProgressHUD.h
//  CNMedicalForDoctor
//  基于MBProgressHUD的二次封装
//  Created by Cyfuer on 15/8/6.
//  Copyright (c) 2015年 Rworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define textActivityIndicatorShowTime 1 //  文字类HUD的延迟时间
#define textActivityIndicatorShowTime2 2 //  文字类HUD的延迟时间

@interface DFProgressHUD : NSObject <MBProgressHUDDelegate>

@property (strong ,nonatomic) MBProgressHUD *progressHUD;

@property (assign ,nonatomic) BOOL isAlertShowing;// 菊花是否正在显示

/**
 *  初始化DFProgressHUD实例
 *
 *  @return DFProgressHUD实例
 */
+ (DFProgressHUD *)shareInstance;


/**
 *  显示活动指示器
 *
 *  @param afterDeleayTime 持续时间，若等于0，在不调用方法隐藏的情况下不会消失
 *  @param title           内容
 *  @param vc              视图控制器
 */
- (void)showActivityIndicator:(CGFloat)afterDeleayTime Title:(NSString *)title view:(UIView *)view;


/**
 *  在view中展示提示框
 *
 *  @param afterDeleayTime 持续时间，若等于0，在不调用方法隐藏的情况下不会消失
 *  @param title           内容
 *  @param vc              视图控制器
 */
- (void)showTextActivityIndicator:(CGFloat)afterDeleayTime Title:(NSString *)title view:(UIView *)view;


/**
 *  隐藏所有菊花和提示框
 */
- (void)hideActivityIndicator;

@end
