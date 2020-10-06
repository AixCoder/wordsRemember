//
//  UIBarButtonItem+AixCatrgory.h
//  AixCategorys
//
//  Created by liuhongnian on 16/10/7.
//  Copyright © 2016年 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AixCatrgory)

- (instancetype)aix_initWithImage:(UIImage *)image
                            style:(UIBarButtonItemStyle) style
                          handler:(void(^)(id sender))action NS_REPLACES_RECEIVER;


@end
