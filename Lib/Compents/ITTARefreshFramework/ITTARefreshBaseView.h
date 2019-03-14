//
//  ITTARefreshBaseView.h
//  ITTARefresh
//  
//  Created by ITTA on 13-3-4.
//  Copyright (c) 2013年 ITTA. All rights reserved.

/*
 * 修改记录
 * 1.新增修改箭头图片的api属性   arrowImg
 *
 */

#import <UIKit/UIKit.h>

@class ITTARefreshBaseView;

#pragma mark - 控件的刷新状态
typedef enum {
	ITTARefreshStatePulling = 1, // 松开就可以进行刷新的状态
	ITTARefreshStateNormal = 2, // 普通状态
	ITTARefreshStateRefreshing = 3, // 正在刷新中的状态
    ITTARefreshStateWillRefreshing = 4
} ITTARefreshState;

#pragma mark - 控件的类型
typedef enum {
    ITTARefreshViewTypeHeader = -1, // 头部控件
    ITTARefreshViewTypeFooter = 1 // 尾部控件
} ITTARefreshViewType;

/**
 类的声明
 */
@interface ITTARefreshBaseView : UIView
#pragma mark - 父控件
@property (nonatomic, weak, readonly) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) UIEdgeInsets scrollViewOriginalInset;

#pragma mark - 内部的控件
@property (nonatomic, weak, readonly) UILabel *statusLabel;
@property (nonatomic, weak, readonly) UIImageView *arrowImage;
@property (nonatomic, weak, readonly) UIActivityIndicatorView *activityView;

#pragma mark - 回调
/**
 *  开始进入刷新状态的监听器
 */
@property (weak, nonatomic) id beginRefreshingTaget;
/**
 *  开始进入刷新状态的监听方法
 */
@property (assign, nonatomic) SEL beginRefreshingAction;
/**
 *  开始进入刷新状态就会调用
 */
@property (nonatomic, copy) void (^beginRefreshingCallback)();

#pragma mark - 刷新相关
/**
 *  是否正在刷新
 */
@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;
/**
 *  开始刷新
 */
- (void)beginRefreshing;
/**
 *  结束刷新
 */
- (void)endRefreshing;

#pragma mark - 交给子类去实现 和 调用
@property (assign, nonatomic) ITTARefreshState state;

@property (nonatomic ,strong) UIImage *arrowImg;
@end