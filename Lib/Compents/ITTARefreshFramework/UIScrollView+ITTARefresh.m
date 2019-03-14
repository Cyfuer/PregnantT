//
//  UIScrollView+ITTARefresh.m
//  ITTARefreshExample
//
//  Created by ITTA on 14-5-28.
//  Copyright (c) 2014年 ITTA. All rights reserved.
//

#import "UIScrollView+ITTARefresh.h"
#import "ITTARefreshHeaderView.h"
#import "ITTARefreshFooterView.h"
#import <objc/runtime.h>

@interface UIScrollView()
@property (weak, nonatomic) ITTARefreshHeaderView *header;
@property (weak, nonatomic) ITTARefreshFooterView *footer;
@end


@implementation UIScrollView (ITTARefresh)

#pragma mark - 运行时相关
static char ITTARefreshHeaderViewKey;
static char ITTARefreshFooterViewKey;

- (void)setHeader:(ITTARefreshHeaderView *)header {
    [self willChangeValueForKey:@"ITTARefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &ITTARefreshHeaderViewKey,
                             header,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ITTARefreshHeaderViewKey"];
}

- (ITTARefreshHeaderView *)header {
    return objc_getAssociatedObject(self, &ITTARefreshHeaderViewKey);
}

- (void)setFooter:(ITTARefreshFooterView *)footer {
    [self willChangeValueForKey:@"ITTARefreshFooterViewKey"];
    objc_setAssociatedObject(self, &ITTARefreshFooterViewKey,
                             footer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ITTARefreshFooterViewKey"];
}

- (ITTARefreshFooterView *)footer {
    return objc_getAssociatedObject(self, &ITTARefreshFooterViewKey);
}

#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback
{
    // 1.创建新的header
    if (!self.header) {
        ITTARefreshHeaderView *header = [ITTARefreshHeaderView header];
        [self addSubview:header];
        self.header = header;
    }
    
    // 2.设置block回调
    self.header.beginRefreshingCallback = callback;
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的header
    if (!self.header) {
        ITTARefreshHeaderView *header = [ITTARefreshHeaderView header];
        [self addSubview:header];
        self.header = header;
    }
    
    // 2.设置目标和回调方法
    self.header.beginRefreshingTaget = target;
    self.header.beginRefreshingAction = action;
}

/**
 *  移除下拉刷新头部控件
 */
- (void)removeHeader
{
    [self.header removeFromSuperview];
    self.header = nil;
}

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing
{
    [self.header beginRefreshing];
}

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing
{
    [self.header endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setHeaderHidden:(BOOL)hidden
{
    self.header.hidden = hidden;
}

- (BOOL)isHeaderHidden
{
    return self.header.isHidden;
}

#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback
{
    // 1.创建新的footer
    if (!self.footer) {
        ITTARefreshFooterView *footer = [ITTARefreshFooterView footer];
        [self addSubview:footer];
        self.footer = footer;
    }
    
    // 2.设置block回调
    self.footer.beginRefreshingCallback = callback;
}

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的footer
    if (!self.footer) {
        ITTARefreshFooterView *footer = [ITTARefreshFooterView footer];
        [self addSubview:footer];
        self.footer = footer;
    }
    
    // 2.设置目标和回调方法
    self.footer.beginRefreshingTaget = target;
    self.footer.beginRefreshingAction = action;
}

/**
 *  移除上拉刷新尾部控件
 */
- (void)removeFooter
{
    [self.footer removeFromSuperview];
    self.footer = nil;
}

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing
{
    [self.footer beginRefreshing];
}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing
{
    [self.footer endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setFooterHidden:(BOOL)hidden
{
    self.footer.hidden = hidden;
}

- (BOOL)isFooterHidden
{
    return self.footer.isHidden;
}

#pragma mark - Setter
- (void)setRefreshLabelColor:(UIColor *)refreshLabelColor {
    [self.header setLabelColor:refreshLabelColor];
    [self.footer setLabelColor:refreshLabelColor];
}

- (void)setArrowImg:(UIImage *)arrowImg {
    self.header.arrowImg = arrowImg;
    self.footer.arrowImg = arrowImg;
}

@end
