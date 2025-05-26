//
//  DragAndDropMethods.h
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
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
