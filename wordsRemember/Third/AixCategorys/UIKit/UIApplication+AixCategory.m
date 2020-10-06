//
//  UIApplication+AixCategory.m
//  AixCategorys
//
//  Created by liuhongnian on 16/9/30.
//  Copyright © 2016年 liuhongnian. All rights reserved.
//

#import "UIApplication+AixCategory.h"
#import "UIDevice+AixCategory.h"

@implementation UIApplication (AixCategory)


+ (BOOL)aix_isAllowedPushNotification
{
    if (iOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        
        UIUserNotificationSettings *setting = [UIApplication sharedApplication].currentUserNotificationSettings;
        
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    }
    
    return NO;
}

@end
