//
//  TipVC.h
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/28.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "BaseVC.h"

@protocol XWTipVCDelegate <NSObject>

- (void)tipVCDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForTipVC;

@end

@interface TipVC : BaseVC

@property (nonatomic, assign) id<XWTipVCDelegate> delegate;

@end
