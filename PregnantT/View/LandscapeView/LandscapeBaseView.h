//
//  LandscapeBaseView.h
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/6.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LandscapeColor.h"

@interface LandscapeBaseView : UIView

@property (strong, nonatomic) NSArray <LandscapeColor *>* colors;// 背景渐变色数组

@end



@interface LandscapeBaseThing : UIView // 事物

@end
