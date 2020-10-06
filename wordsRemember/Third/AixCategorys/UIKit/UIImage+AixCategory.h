//
//  UIImage+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 16/10/7.
//  Copyright © 2016年 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AixCategory)

+ (nullable UIImage *)aix_appLaunchImage;
//截屏
+(nullable UIImage*)aix_snapshotCurrentScreen;
//圆形图片
+ (UIImage *_Nullable)x_GetRoundImagewithImage:(UIImage *_Nullable)image;

//图片模糊效果
- (UIImage *_Nullable)x_blur;

- (nullable UIImage*)x_imageByRotateLeft90;
- (nullable UIImage*)x_imageByRotateRight90;
- (nullable UIImage*)x_imageByRotate180;

- (nullable UIImage*)x_imageByFlipVertical;
- (nullable UIImage*)x_imageByFlipHorizontal;

- (nullable UIImage*)x_imageByGrayScale;
- (nullable UIImage*)x_imageByBlurSoft;
- (nullable UIImage*)x_imageByBlurExtraLight;
- (nullable UIImage*)x_imageByBlurDark;

- (nullable UIImage *)x_imageByBlurRadius:(CGFloat)blurRadius
                              tintColor:(nullable UIColor *)tintColor
                               tintMode:(CGBlendMode)tintBlendMode
                             saturation:(CGFloat)saturation
                              maskImage:(nullable UIImage *)maskImage;


+ (nullable UIImage *)x_imageWithColor:(UIColor *_Nonnull)color size:(CGSize)size;

- (nullable UIImage*)x_imageByRoundCornerRadius:(CGFloat)radius;

- (nullable UIImage *)x_imageByRoundCornerRadius:(CGFloat)radius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(nullable UIColor *)borderColor;

- (nullable UIImage *)x_imageByRoundCornerRadius:(CGFloat)radius
                                corners:(UIRectCorner)corners
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(nullable UIColor *)borderColor
                         borderLineJoin:(CGLineJoin)borderLineJoin;

/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *_Nullable)x_imageWithGIFNamed:(NSString *_Nullable)name;

@end
