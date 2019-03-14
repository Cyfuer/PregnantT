//
//  SongVC.h
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/28.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "BaseVC.h"

@protocol XWSongVCDelegate <NSObject>

- (void)songVCDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForSongVC;

@end

@interface SongVC : BaseVC

@property (nonatomic, assign) id<XWSongVCDelegate> delegate;

@end
