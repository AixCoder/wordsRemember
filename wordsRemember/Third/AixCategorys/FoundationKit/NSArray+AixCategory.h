//
//  NSArray+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 10/25/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (AixCategory)


/**
 防止越界

 @param index <#index description#>
 @return <#return value description#>
 */
- (id)x_safeObjectAtIndex:(NSUInteger)index;


/**
 随机读取其中一个元素

 @return 随机值
 */
- (id)x_randomObject;


/**
 数组对象转成JSON字符串

 @return json string
 */
- (NSString *)x_toJSONString;


@end
