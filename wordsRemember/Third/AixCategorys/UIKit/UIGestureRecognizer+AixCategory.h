//
//  UIGestureRecognizer+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 11/3/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (AixCategory)

- (void)x_addActionBlock:(void(^)(id sender))block;

@end
