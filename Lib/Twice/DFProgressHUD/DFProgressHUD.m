//
//  DFProgressHUD.m
//  CNMedicalForDoctor
//
//  Created by Cyfuer on 15/8/6.
//  Copyright (c) 2015年 Rworld. All rights reserved.
//

#import "DFProgressHUD.h"

static DFProgressHUD *dfProgressHUD = nil;
@interface DFProgressHUD()

@end

@implementation DFProgressHUD


#pragma mark  -  public
+ (DFProgressHUD *)shareInstance {
    @synchronized (self) {
        
        if (dfProgressHUD == nil) {
            dfProgressHUD = [[self alloc] init];
        }
    }
    return dfProgressHUD;
}

- (void)showActivityIndicator:(CGFloat)afterDelayTime Title:(NSString *)title view:(UIView *)view {
    // 如果view存在，活动指示器添加在view上，否则检测window是否存在，若存在，添加在window上，否则不添加。
    UIView *superView;
    if (view) {
        superView = view;
    } else if ([self getWindow]) {
        superView = [self getWindow];
    } else {
        superView = nil;
    }
    
    [self initProgressHUD_withView:superView];
    [self showHUDWithTime:afterDelayTime Title:title];
}

- (void)showTextActivityIndicator:(CGFloat)afterDelayTime Title:(NSString *)title view:(UIView *)view {
    [self initProgressHUD_withView:view];
    [self showTextWith:afterDelayTime Title:title];
}

#pragma mark  -  private
+ (id)allocWithZone:(NSZone *)zone {//第三步：重写allocWithZone方法
    
    @synchronized (self) {
        
        if (dfProgressHUD == nil) {
            
            dfProgressHUD = [super allocWithZone:zone];
            
            return dfProgressHUD;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {//第四步
    
    return self;
}

- (id)init {
    @synchronized(self) {
        self = [super init];//往往放一些要初始化的变量.
        return self;
    }
}

- (void)initProgressHUD_withView:(UIView *)view {
    // 如果window 存在，显示在window上，否则显示在view 上
    UIWindow *window = [self getWindow];
    if (window) {
        [self setProgressHudWithType:0 view:window];
    }
    else if (view) {
        [self setProgressHudWithType:1 view:view];
    }
}

/**
 *  初始化Progress
 *
 *  @param type 视图类型 0.window 1.view
 */
- (void)setProgressHudWithType:(NSInteger)type view:(UIView *)view {
    if (self.progressHUD) {
        [view addSubview:self.progressHUD];
    }
    else {
        self.progressHUD.delegate = self;
        self.progressHUD = [[MBProgressHUD alloc]initWithView:view];
        [view addSubview:self.progressHUD];
    }
    self.progressHUD.minShowTime = 0.5f;
}

- (void)showHUDWithTime:(CGFloat)afterDelayTime Title:(NSString *)title {
    _progressHUD.animationType = MBProgressHUDAnimationZoom;
    _progressHUD.mode = MBProgressHUDModeIndeterminate;
    if (afterDelayTime != 0) {
        [_progressHUD hideAnimated:YES afterDelay:afterDelayTime];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterDelayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _isAlertShowing = NO;
            [_progressHUD hideAnimated:YES];
        });
    }
    if (title && title.length) {
        _progressHUD.detailsLabel.text = nil;
        _progressHUD.label.text = [NSString stringWithFormat:@"%@...",title];
    }
    else {
        _progressHUD.detailsLabel.text = nil;
        _progressHUD.label.text = nil;
    }
    
    if (!_isAlertShowing) {
        _isAlertShowing = YES;
        [_progressHUD showAnimated:YES];
    }
}

- (void)showTextWith:(CGFloat)afterDeleayTime Title:(NSString *)title {
    _progressHUD.animationType = MBProgressHUDAnimationZoom;
    _progressHUD.mode = MBProgressHUDModeText;
    if (afterDeleayTime != 0) {
        [_progressHUD hideAnimated:YES afterDelay:afterDeleayTime];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterDeleayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _isAlertShowing = NO;
            [_progressHUD hideAnimated:YES];
        });
    }
    if (title && title.length) {
        _progressHUD.label.text = [NSString stringWithFormat:@"%@",title];
        _progressHUD.detailsLabel.text = nil;
    }
    else {
        _progressHUD.label.text = nil;
        _progressHUD.detailsLabel.text = nil;
    }
    
    if (!_isAlertShowing) {
        _isAlertShowing = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_progressHUD showAnimated:YES];
        });
        
    }
}

- (void)hideActivityIndicator {
    if (_progressHUD) {
        _isAlertShowing = NO;
        [_progressHUD hideAnimated:YES];
    }
}

- (UIWindow *)getWindow {
    return [[UIApplication sharedApplication] keyWindow];
}


#pragma mark  -  delegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    _isAlertShowing = NO;
}

@end
