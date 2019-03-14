//
//  MusicPlayerView.h
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/29.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayerView : UIView // 音乐播放界面

@end



@interface SubMusicPlayerRingView : UIView // 中间的圆环

@property (strong, nonatomic) NSArray <UIColor *> *customColors;// 自定义渐变色圆环的颜色
@property (strong, nonatomic) NSArray <NSNumber *>*customLocations;// 自定义渐变色圆环的颜色频率
 
@end



@interface SubMusicPlayerVoiceView : UIView // 音量视图

@end

@interface SubVoiceLayer : CALayer

@property (assign, nonatomic) CGRect height; // 当音量显示到最大值时图层的高度

@property (assign, nonatomic) CGFloat minNumber;// 显示的音量最小值
@property (assign, nonatomic) CGFloat maxNumber;// 显示的音量最大值
@property (assign, nonatomic) CGFloat curNumber;// 当前显示的音量值

@end
