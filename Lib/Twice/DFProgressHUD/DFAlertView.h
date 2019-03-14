//
//  DFAlertView.h
//  iFlashBuy_6
//
//  Created by Cyfuer on 16/1/11.
//  Copyright © 2016年 width. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFAlertView : UIAlertView

+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
         completionBlock:(void (^)(NSUInteger buttonIndex, DFAlertView *alertView))block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSArray *)otherButtonTitles;

@end
