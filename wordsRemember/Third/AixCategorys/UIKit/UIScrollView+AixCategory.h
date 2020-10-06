//
//  UIScrollView+AixCategory.h
//  AixCategorys
//
//  Created by user on 2017/11/24.
//  Copyright © 2017年 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (AixCategory)

- (void)x_scrollToTopAnimated:(BOOL)animated;
- (void)x_scrollToBottomAnimated:(BOOL)animated;
- (void)x_scrollToLeftAnimated:(BOOL)animated;
- (void)x_scrollToRightAnimated:(BOOL)animated;

@end
