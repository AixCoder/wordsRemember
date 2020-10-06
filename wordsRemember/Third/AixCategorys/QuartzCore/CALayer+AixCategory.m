//
//  CALayer+AixCategory.m
//  AixCategorys
//
//  Created by liuhongnian on 2018/6/22.
//  Copyright © 2018年 liuhongnian. All rights reserved.
//

#import "CALayer+AixCategory.h"

@implementation CALayer (AixCategory)

@dynamic XBorderColor;

- (void)setXBorderColor:(UIColor *)XBorderColor
{
    self.borderColor = XBorderColor.CGColor;
}

@end
