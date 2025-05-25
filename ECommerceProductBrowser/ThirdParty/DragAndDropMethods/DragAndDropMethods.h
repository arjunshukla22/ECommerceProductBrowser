//
//  DragAndDropMethods.h
//  PrepLadder
//
//  Created by Prepladder Pvt ltd on 02/11/21.
//  Copyright © 2021 PrepLadder. All rights reserved.
//

#ifndef DragAndDropMethods_h
#define DragAndDropMethods_h

#endif /* DragAndDropMethods_h */

#import <UIKit/UIKit.h>

@interface DragAndDropMethods : NSObject {
}
+ (void)hideViewWithAnimation :(UIView *)baseView heightOfView:(CGFloat)height popUpview:(UIView*)popup;
+ (void)showViewWithAnimation:(UIView *)baseView heightOfView:(CGFloat )height popUpview:(UIView*)popup;

@end
