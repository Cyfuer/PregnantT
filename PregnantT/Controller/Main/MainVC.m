//
//  MainVC.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/11/25.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "MainVC.h"
#import "FoodCell.h"
#import "FoodColledtionViewLayout.h"
#import "FoodHeader.h"
#import "XWPresentOneTransition.h"
#import "XWInteractiveTransition.h"
#import "SongVC.h"
#import "TipVC.h"


static NSString *const foodCellIdentifier = @"FoodCell";


@interface MainVC () <XWSongVCDelegate,XWTipVCDelegate> {
    XWInteractiveTransition *songPush;
    XWInteractiveTransition *tipPush;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) FoodHeader *header;

@end


@implementation MainVC


#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
    [self setupGesture];
    [self.view addSubview:self.header];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)setupCollectionView {
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.decelerationRate = 0.1;
    self.collectionView.contentInset = UIEdgeInsetsMake(kFoodHeader_MaxHeight - kFoodHeader_MinHeight, 0, 0, 0);
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
    
    [self.collectionView setCollectionViewLayout:[[FoodColledtionViewLayout alloc] init]];
    [self.collectionView registerNib:[UINib nibWithNibName:foodCellIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:foodCellIdentifier];
}

- (void)setupGesture {
    // 跳转到SongVC的转场动画
    songPush = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePresent GestureDirection:XWInteractiveTransitionGestureDirectionRight];
    typeof(self)songSelf = self;
    songPush.presentConifg = ^(){
        [songSelf presentSongVC];
    };
    [songPush addEdgePanGestureForViewController:self];
    
    // 跳转到TipVC的转场动画
    tipPush = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePresent GestureDirection:XWInteractiveTransitionGestureDirectionLeft];
    typeof(self)tipSelf = self;
    tipPush.presentConifg = ^(){
        [tipSelf presentTipVC];
    };
    [tipPush addEdgePanGestureForViewController:self];
}

- (void)presentSongVC {
    SongVC *vc = [SongVC new];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)presentTipVC {
    TipVC *vc = [TipVC new];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Private
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if ([object isKindOfClass:[UICollectionView class]]) {
            
//            NSLog(@"%f",((UICollectionView*)object).contentOffset.y);
//            [self.header layoutByOffset:((UICollectionView*)object).contentOffset];
            
            CGFloat y = ((UICollectionView*)object).contentOffset.y;
//            CGFloat pro = MAX(-y/(H-navigationH), 0);
//            CGFloat d = MAX(1-pro, 0);
            
            if (y < 0) {
                self.header.frame = CGRectMake(0, 0, self.view.width, (-y)+kFoodHeader_MinHeight);
            } else {
                if (self.header.frame.size.height != kFoodHeader_MinHeight) {
                    [UIView animateWithDuration:1 animations:^{
                        self.header.frame = CGRectMake(0, 0, self.view.width, kFoodHeader_MinHeight);
                    }];
                }
            }
        
//            if (-y > kFoodHeader_MaxHeight-kFoodHeader_MinHeight) {
//                self.header.frame = CGRectMake(0, 0, self.view.width, (-y)+kFoodHeader_MinHeight);
//            }
            
//            if (d >= 0.5f) {
//                if (!_isShow) {
//                    [self AppearsTitleLabel];
//                }
//            } else {
//                if (_isShow) {
//                    [self DisappearTitleLabel];
//                }
//            }
            
        }
    }
}


#pragma mark - XWSongVCDelegate
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForSongVC {
    return songPush;
}

- (void)songVCDissmiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - XWTipVCDelegate
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForTipVC {
    return tipPush;
}

- (void)tipVCDissmiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:foodCellIdentifier forIndexPath:indexPath];
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    [((FoodCell *)cell) setIsShow:YES];
//}
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    [((FoodCell *)cell) setIsShow:NO];
//}

#pragma mark - Getter
- (FoodHeader *)header {
    if (!_header) {
        FoodHeader *headerView = [FoodHeader loadView];
        headerView.frame = CGRectMake(0, 0, self.view.width, kFoodHeader_MaxHeight);
        
        _header = headerView;
    }
    return _header;
}

@end
