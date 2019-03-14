//
//  ITTARefreshTableFooterView.h
//  ITTARefresh
//
//  Created by ITTA on 13-2-26.
//  Copyright (c) 2013年 ITTA. All rights reserved.
//  上拉加载更多

/*
 *  修改记录
 *  1.添加修改字体颜色的API    - (void)setLabelColor:(UIColor *)color;
 */

#import "ITTARefreshBaseView.h"

@interface ITTARefreshFooterView : ITTARefreshBaseView
+ (instancetype)footer;
- (void)setLabelColor:(UIColor *)color;
@end