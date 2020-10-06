//
//  UIApplication+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 16/9/30.
//  Copyright © 2016年 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (AixCategory)


/**
 检查APP是否打开推送开关

 @return yes 开启推送
 */
+ (BOOL)aix_isAllowedPushNotification;

@end
