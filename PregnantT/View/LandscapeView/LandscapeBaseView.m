//
//  LandscapeBaseView.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/6.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "LandscapeBaseView.h"

@implementation LandscapeBaseView

#pragma mark - Intializer
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - Private
- (void)handleTapGesture:(UIGestureRecognizer *)tap {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@implementation LandscapeBaseThing

@end

