//
//  UINavigationController+AixCategory.m
//  AixCategorys
//
//  Created by user on 2017/10/31.
//  Copyright © 2017年 liuhongnian. All rights reserved.
//

#import "UINavigationController+AixCategory.h"

@implementation UINavigationController (AixCategory)

- (UIViewController *)x_rootViewController
{
    if (self.viewControllers && [self.viewControllers count] >0)
    {
        return [self.viewControllers firstObject];
    }
    return nil;
}

- (NSArray *)x_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated
{
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}


@end
