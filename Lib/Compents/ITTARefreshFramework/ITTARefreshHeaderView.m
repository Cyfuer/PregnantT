//
//  ITTARefreshHeaderView.m
//  ITTARefresh
//
//  Created by ITTA on 13-2-26.
//  Copyright (c) 2013年 ITTA. All rights reserved.
//  下拉刷新

#import "ITTARefreshConst.h"
#import "ITTARefreshHeaderView.h"
#import "UIView+Extension.h"
#import "UIScrollView+Extension.h"

@interface ITTARefreshHeaderView()
// 最后的更新时间
@property (nonatomic, strong) NSDate *lastUpdateTime;
@property (nonatomic, weak) UILabel *lastUpdateTimeLabel;
@end

@implementation ITTARefreshHeaderView
#pragma mark - 控件初始化
/**
 *  时间标签
 */
- (UILabel *)lastUpdateTimeLabel
{
    if (!_lastUpdateTimeLabel) {
        // 1.创建控件
        UILabel *lastUpdateTimeLabel = [[UILabel alloc] init];
        lastUpdateTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        lastUpdateTimeLabel.font = [UIFont boldSystemFontOfSize:12];
        lastUpdateTimeLabel.textColor = ITTARefreshLabelTextColor;
        lastUpdateTimeLabel.backgroundColor = [UIColor clearColor];
        lastUpdateTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lastUpdateTimeLabel = lastUpdateTimeLabel];
        
        // 2.加载时间
        self.lastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:ITTARefreshHeaderTimeKey];
        
        // 更新时间字符串
        [self updateTimeLabel];//////////////////待测
    }
    return _lastUpdateTimeLabel;
}

+ (instancetype)header
{
    return [[ITTARefreshHeaderView alloc] init];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat statusX = 0;
    CGFloat statusY = 0;
    CGFloat statusHeight = self.height * 0.5;
    CGFloat statusWidth = self.width;
    // 1.状态标签
    self.statusLabel.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight);
    
    // 2.时间标签
    CGFloat lastUpdateY = statusHeight;
    CGFloat lastUpdateX = 0;
    CGFloat lastUpdateHeight = statusHeight;
    CGFloat lastUpdateWidth = statusWidth;
    self.lastUpdateTimeLabel.frame = CGRectMake(lastUpdateX, lastUpdateY, lastUpdateWidth, lastUpdateHeight);
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 设置自己的位置和尺寸
    self.y = - self.height;
}

#pragma mark - 状态相关
#pragma mark 设置最后的更新时间
- (void)setLastUpdateTime:(NSDate *)lastUpdateTime
{
    _lastUpdateTime = lastUpdateTime;
    
    // 1.归档
    [[NSUserDefaults standardUserDefaults] setObject:lastUpdateTime forKey:ITTARefreshHeaderTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 2.更新时间
    [self updateTimeLabel];
}

#pragma mark - Public Methods
- (void)setLabelColor:(UIColor *)color {
    _lastUpdateTimeLabel.textColor = color;
    self.statusLabel.textColor = color;
}

#pragma mark 更新时间字符串
- (void)updateTimeLabel
{
    if (!self.lastUpdateTime){
        
        NSDateFormatter *dateformatter =[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"最后更新：今天 HH:mm"];
        self.lastUpdateTimeLabel.text = [[NSString alloc] initWithFormat:@"%@",[dateformatter stringFromDate:[NSDate date]]];;
        return;
    }
    
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:_lastUpdateTime];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天 HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *time = [formatter stringFromDate:self.lastUpdateTime];
    
    // 3.显示日期
    self.lastUpdateTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
}

#pragma mark - 监听UIScrollView的contentOffset属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;

    // 如果正在刷新，直接返回
    if (self.state == ITTARefreshStateRefreshing) return;

    if ([ITTARefreshContentOffset isEqualToString:keyPath]) {
        [self adjustStateWithContentOffset];
    }
}

/**
 *  调整状态
 */
- (void)adjustStateWithContentOffset
{
    // 当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.contentOffsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    if (currentOffsetY >= happenOffsetY) return;
    
    if (self.scrollView.isDragging) {
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY - self.height;
        
        if (self.state == ITTARefreshStateNormal && currentOffsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = ITTARefreshStatePulling;
        } else if (self.state == ITTARefreshStatePulling && currentOffsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = ITTARefreshStateNormal;
        }
    } else if (self.state == ITTARefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        self.state = ITTARefreshStateRefreshing;
    }
}

#pragma mark 设置状态
- (void)setState:(ITTARefreshState)state
{
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.保存旧状态
    ITTARefreshState oldState = self.state;
    
    // 3.调用父类方法
    [super setState:state];
    
    // 4.根据状态执行不同的操作
	switch (state) {
		case ITTARefreshStateNormal: // 下拉可以刷新
        {
            // 设置文字
			self.statusLabel.text = ITTARefreshHeaderPullToRefresh;
            
            // 刷新完毕
            if (ITTARefreshStateRefreshing == oldState) {
                self.arrowImage.transform = CGAffineTransformIdentity;
                // 保存刷新时间
                self.lastUpdateTime = [NSDate date];
                
                [UIView animateWithDuration:ITTARefreshSlowAnimationDuration animations:^{
                    self.scrollView.contentInsetTop = self.scrollViewOriginalInset.top;
                }];
            } else {
                // 执行动画
                [UIView animateWithDuration:ITTARefreshFastAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformIdentity;
                }];
            }
			break;
        }
            
		case ITTARefreshStatePulling: // 松开可立即刷新
        {
            // 设置文字
            self.statusLabel.text = ITTARefreshHeaderReleaseToRefresh;
            // 执行动画
            [UIView animateWithDuration:ITTARefreshFastAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
            }];
			break;
        }
            
		case ITTARefreshStateRefreshing: // 正在刷新中
        {
            // 设置文字
            self.statusLabel.text = ITTARefreshHeaderRefreshing;
            
            // 执行动画
            [UIView animateWithDuration:ITTARefreshFastAnimationDuration animations:^{
                // 1.增加滚动区域
                CGFloat top = self.scrollViewOriginalInset.top + self.height;
                self.scrollView.contentInsetTop = top;
                
                // 2.设置滚动位置
                self.scrollView.contentOffsetY = - top;
            }];
			break;
        }
            
        default:
            break;
	}
}
@end