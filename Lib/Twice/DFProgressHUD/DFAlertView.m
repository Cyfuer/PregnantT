//
//  DFAlertView.m
//  iFlashBuy_6
//
//  Created by Cyfuer on 16/1/11.
//  Copyright © 2016年 width. All rights reserved.
//

#import "DFAlertView.h"
#import <objc/runtime.h>

@interface DFAlertView ()

@end

@implementation DFAlertView

void EMNoTitleAlert(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

+ (id)showAlertWithTitle:(NSString *)title message:(NSString *)message
         completionBlock:(void (^)(NSUInteger buttonIndex, DFAlertView *alertView))block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSArray *)otherButtonTitles {
    if (!cancelButtonTitle && !otherButtonTitles) {
        return nil;
    }
    DFAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                         completionBlock:block
                                       cancelButtonTitle:cancelButtonTitle
                                       otherButtonTitles:otherButtonTitles];
    
    [alertView show];
    
    return alertView;
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    void (^block)(NSUInteger buttonIndex, UIAlertView *alertView) = objc_getAssociatedObject(self, "blockCallback");
    if (block) {
        block(buttonIndex, self);
    }
}


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
    completionBlock:(void (^)(NSUInteger buttonIndex, DFAlertView *alertView))block
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles {
    
    objc_setAssociatedObject(self, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self = [self initWithTitle:title
                           message:message
                          delegate:self
                 cancelButtonTitle:nil
                 otherButtonTitles:nil]) {
        
        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            self.cancelButtonIndex = [self numberOfButtons] - 1;
        }
        
        if (otherButtonTitles && otherButtonTitles.count) {
            for (NSString *title in otherButtonTitles) {
                [self addButtonWithTitle:title];
            }
        }
    }
    return self;
}

@end
