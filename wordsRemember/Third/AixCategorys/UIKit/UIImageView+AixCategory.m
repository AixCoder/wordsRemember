//
//  UIImageView+AixCategory.m
//  AixCategorys
//
//  Created by user on 2017/10/31.
//  Copyright © 2017年 liuhongnian. All rights reserved.
//

#import "UIImageView+AixCategory.h"

@implementation UIImageView (AixCategory)

+(instancetype)x_imageViewWithPNGImage:(NSString *)imageName frame:(CGRect)frame
{
    UIImageView *imageV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageV.frame=frame;
    return imageV;
}
@end
