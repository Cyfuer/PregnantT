//
//  LandscapeSkyWindMill.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/9.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "LandscapeSkyWindMill.h"

@interface LandscapeSkyWindMill ()

@property (strong, nonatomic) UIImageView *houseImgView;
@property (strong, nonatomic) UIImageView *windMillImgView;

@end

@implementation LandscapeSkyWindMill

#pragma mark - Intializer
- (instancetype)initWithFrame:(CGRect)frame {
    
    UIImage *houseImg = [UIImage imageNamed:@"house"];
    UIImage *windMillImg = [UIImage imageNamed:@"windmill"];
    CGRect rect = CGRectMake(frame.origin.x, frame.origin.y, kLandscapeSkyWindMill_WIDTH, kLandscapeSkyWindMill_HEIGHT);
    
    self = [super initWithFrame:rect];
    if (self) {

        _houseImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _houseImgView.image = houseImg;
        _windMillImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _windMillImgView.image = windMillImg;
        [self addSubview:_houseImgView];
        [self addSubview:_windMillImgView];
        
        [self rotate360DegreeWithImageView:_windMillImgView];
    }
    return self;
}

- (void)rotate360DegreeWithImageView:(UIImageView *)imageView{
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         
                         CATransform3DMakeRotation(- M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = 20;
    animation.speed = -10;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = INFINITY;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
//    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
//    UIGraphicsBeginImageContext(imageRrect.size);
//    [imageView.image drawInRect:CGRectMake(1,1,imageView.frame.size.width-2,imageView.frame.size.height-2)];
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    [imageView.layer addAnimation:animation forKey:nil];
}


@end
