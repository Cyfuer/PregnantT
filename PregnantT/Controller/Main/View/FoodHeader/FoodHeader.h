//
//  FoodHeader.h
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/20.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kFoodHeader_MinHeight 64
#define kFoodHeader_MaxHeight 240

@class FoodHeaderGradientView,FoodHeaderCloundView;
@interface FoodHeader : UIView
@property (weak, nonatomic) IBOutlet FoodHeaderGradientView *gradientView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gradientViewH;

@property (strong, nonatomic) NSTimer *timer;

+ (instancetype) loadView;
- (void)layoutByOffset:(CGPoint)offset;

@end


@interface FoodHeaderGradientView : UIView // 颜色渐变视图

@property (strong, nonatomic) NSArray <UIColor *>*colors;
@property (strong, nonatomic) NSArray <NSNumber *>*locations;// 以单位坐标系标定，即0-1之间的值，设置后颜色位置按数组内的值变化，数组长度必须跟foreColors保持一致,可以不设置，

@property (assign, nonatomic) CGPoint startPoint;// 渐变开始位置，以单位坐标系标定
@property (assign, nonatomic) CGPoint endPoint;// 渐变结束位置，startPoint、endPoint一起决定了渐变的方向

@end


@interface FoodHeaderCloundView : UIImageView

@property (assign, nonatomic) CGRect formerFrame;

/**
 获取实例

 @param rect 云朵中心点的运动区域
 @return 云朵实例
 */
+ (instancetype)cloundWithRect:(CGRect)rect;

@end
