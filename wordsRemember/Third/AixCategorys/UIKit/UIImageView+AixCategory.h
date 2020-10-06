//
//  UIImageView+AixCategory.h
//  AixCategorys
//
//  Created by user on 2017/10/31.
//  Copyright © 2017年 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AixCategory)

//快速创建imageView
+(instancetype)x_imageViewWithPNGImage:(NSString *)imageName frame:(CGRect)frame;

@end
