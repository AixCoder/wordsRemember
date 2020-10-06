//
//  NSDate+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 10/25/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AixCategory)
@property (nonatomic, readonly) NSInteger x_year; ///< Year component
@property (nonatomic, readonly) NSInteger x_month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger x_day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger x_weekDay;//星期几（1-7）

@property (nonatomic,readonly) BOOL isToday;

- (NSString *)x_timeAgo;// * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
- (NSString *)x_timestamp;//时间戳(当前时间)



@end
