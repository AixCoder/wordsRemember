//
//  UIButton+AixCategory.h
//  AixCategorys
//
//  Created by user on 2017/11/2.
//  Copyright © 2017年 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AixCategory)

/** 改变按钮的响应区域,上左下右分别增加或减小多少  正数为增加 负数为减小*/
@property (nonatomic, assign) UIEdgeInsets clickEdgeInsets;

@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;// 给重复点击加间隔

@end
