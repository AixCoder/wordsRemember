//
//  UINavigationController+AixCategory.h
//  AixCategorys
//
//  Created by user on 2017/10/31.
//  Copyright © 2017年 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (AixCategory)

//根视图控制器
- (UIViewController *)x_rootViewController;
//pop 回 第n层
- (NSArray *)x_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;

@end
