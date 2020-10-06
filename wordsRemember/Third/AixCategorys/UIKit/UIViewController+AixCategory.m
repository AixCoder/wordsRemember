//
//  UIViewController+AixCategory.m
//  AixCategorys
//
//  Created by liuhongnian on 10/25/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import "UIViewController+AixCategory.h"

@implementation UIViewController (AixCategory)

+ (instancetype)aix_topViewController
{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    return [self findCurrentViewController:rootVC];
    
}

+ (UIViewController *)findCurrentViewController:(UIViewController *)viewController
{
    UIViewController *currentVC = viewController;
    if (viewController.presentedViewController) {
        
        [self findCurrentViewController:viewController.presentedViewController];
        
    }else if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *navController = (UINavigationController*)viewController;
        [self findCurrentViewController:navController.visibleViewController];
        
    }else if ([viewController isKindOfClass:[UITabBarController class]]){
        
        UITabBarController *tabBarCtrl = (UITabBarController*)viewController;
        [self findCurrentViewController:tabBarCtrl.selectedViewController];
        
    }else if ([viewController isKindOfClass:[UIViewController class]]){
        
        return currentVC;
    }
    
    return nil;
}

- (BOOL)x_isVisible
{
    return ([self isViewLoaded] && self.view.window);
}

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               cancelTitle:(NSString *)cancel_title
              cancelAction:(void(^)(void))cancelHandle
                 doneTitle:(NSString *)done_title
                doneAction:(void(^)(void))doneHandle
{
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelHandle();
    }];
    
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        doneHandle();
    }];
    
    [alertViewController addAction:cancelAction];
    [alertViewController addAction:doneAction];
    [self presentViewController:alertViewController animated:YES completion:^{
        
    }];
    
}

- (void)x_backToViewController:(NSString *)viewController animated:(BOOL)animated
{
    if (self.navigationController) {
        
        NSArray *vcArray = self.navigationController.viewControllers;
        for (UIViewController *subViewController in vcArray) {
            if ([subViewController isKindOfClass:NSClassFromString(viewController)]) {
                
                [self.navigationController popToViewController:subViewController
                                                      animated:animated];
                return;
                
            }
        }
        if (vcArray.count >= 2) {
            NSLog(@"%@没有成功匹配",viewController);
            [self.navigationController popViewControllerAnimated:animated];
        }
    }
}

@end
