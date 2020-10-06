//
//  UIControl+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 1/4/17.
//  Copyright © 2017 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (AixCategory)

- (void)xAddBlock:(void(^)(id sender))block
 ForControlEvents:(UIControlEvents)controlEvents;

@end
