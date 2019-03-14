//
//  XWPresentOneTransition.h
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/24.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XWPresentOneTransitionType) {
    XWPresentOneTransitionTypePresent = 0,
    XWPresentOneTransitionTypeDismiss
};

// 动画运动的方向
typedef NS_ENUM(NSUInteger, XWPresentOneTransitionDirection) {
    XWPresentOneTransitionDirectionLeft = 0,
    XWPresentOneTransitionDirectionRight
};

@interface XWPresentOneTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(XWPresentOneTransitionType)type direction:(XWPresentOneTransitionDirection)direction;
- (instancetype)initWithTransitionType:(XWPresentOneTransitionType)type direction:(XWPresentOneTransitionDirection)direction;

@end
