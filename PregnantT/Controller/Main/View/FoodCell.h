//
//  FoodCell.h
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/16.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;// 已收藏、已浏览、无状态
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@end
