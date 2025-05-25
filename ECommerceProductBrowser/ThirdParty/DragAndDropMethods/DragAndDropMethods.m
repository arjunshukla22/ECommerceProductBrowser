//
//  DragAndDropMethods.m
//  PrepLadder
//
//  Created by Prepladder Pvt ltd on 02/11/21.
//  Copyright © 2021 PrepLadder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DragAndDropMethods.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height


@implementation DragAndDropMethods


#pragma mark:- Custom Actions
+ (void)hideViewWithAnimation:(UIView *)baseView heightOfView:(CGFloat )height popUpview:(UIView*)popup {
    CGAffineTransform top  = CGAffineTransformMakeTranslation(0, height);
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        popup.transform = top;
    } completion:^(BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            baseView.hidden = TRUE;
        });
    }];
    
}

// Generic Drop Down Show with Animation by Harsh

+ (void)showViewWithAnimation:(UIView *)baseView heightOfView:(CGFloat)height popUpview:(UIView *)popup
{
    baseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    popup.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [UIView animateWithDuration:0.7 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut animations:^{
        popup.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished)
     {
    }];
    
}

@end

