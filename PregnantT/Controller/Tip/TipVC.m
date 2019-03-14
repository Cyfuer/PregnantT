//
//  TipVC.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/28.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "TipVC.h"
#import "XWPresentOneTransition.h"
#import "XWInteractiveTransition.h"

@interface TipVC () <UIViewControllerTransitioningDelegate> {
    XWInteractiveTransition *interactiveDismiss;
}

@end

@implementation TipVC

#pragma mark - Intialize
- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    lab.text = @"TipVC";
    [self.view addSubview:lab];
    
    [self setupGesture];
}

- (void)setupGesture {
    interactiveDismiss = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypeDismiss GestureDirection:XWInteractiveTransitionGestureDirectionRight];
    [interactiveDismiss addEdgePanGestureForViewController:self];
}

#pragma mark - Private
- (void)dismiss{
    if (_delegate && [_delegate respondsToSelector:@selector(tipVCDissmiss)]) {
        [_delegate tipVCDissmiss];
    }
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [XWPresentOneTransition transitionWithTransitionType:XWPresentOneTransitionTypePresent direction:XWPresentOneTransitionDirectionLeft];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [XWPresentOneTransition transitionWithTransitionType:XWPresentOneTransitionTypeDismiss  direction:XWPresentOneTransitionDirectionRight];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return interactiveDismiss.interation ? interactiveDismiss : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    XWInteractiveTransition *interactivePresent = [_delegate interactiveTransitionForTipVC];
    return interactivePresent.interation ? interactivePresent : nil;
}


@end
