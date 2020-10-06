//
//  UIViewController+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 10/25/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AixCategory)

+ (instancetype)aix_topViewController;

- (BOOL)x_isVisible;

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               cancelTitle:(NSString *)cancel_title
              cancelAction:(void(^)(void))cancelHandle
                 doneTitle:(NSString *)done_title
                doneAction:(void(^)(void))doneHandle;

- (void)x_backToViewController:(NSString *)viewController
                      animated:(BOOL)animated;

@end
