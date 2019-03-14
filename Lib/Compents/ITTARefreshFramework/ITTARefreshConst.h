//
//  ITTARefreshConst.h
//  ITTARefresh
//
//  Created by ITTA on 14-1-3.
//  Copyright (c) 2014年 ITTA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#ifdef DEBUG
#define ITTALog(...) NSLog(__VA_ARGS__)
#else
#define ITTALog(...)
#endif

#define ITTAColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 文字颜色
#define ITTARefreshLabelTextColor ITTAColor(255, 255, 255)

extern const CGFloat ITTARefreshViewHeight;
extern const CGFloat ITTARefreshFastAnimationDuration;
extern const CGFloat ITTARefreshSlowAnimationDuration;

extern NSString *const ITTARefreshBundleName;

#define ITTARefreshSrcName(file) [ITTARefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const ITTARefreshFooterPullToRefresh;
extern NSString *const ITTARefreshFooterReleaseToRefresh;
extern NSString *const ITTARefreshFooterRefreshing;

extern NSString *const ITTARefreshHeaderPullToRefresh;
extern NSString *const ITTARefreshHeaderReleaseToRefresh;
extern NSString *const ITTARefreshHeaderRefreshing;
extern NSString *const ITTARefreshHeaderTimeKey;

extern NSString *const ITTARefreshContentOffset;
extern NSString *const ITTARefreshContentSize;
