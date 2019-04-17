//
//  UIImage+ZJAdd.h
//  kitdemo
//
//  Created by zj on 2019/4/5.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZJAdd)

- (UIImage *)zj_imageByResizeToSize:(CGSize)size;

- (UIImage *)zj_imageByRoundCornerRadius:(CGFloat)radius
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(nullable UIColor *)borderColor;

+ (UIImage *)zj_imageWithColor:(UIColor *)color size:(CGSize)size;


- (UIImage *)zj_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;


- (UIImage *)zj_imageByTintColor:(UIColor *)color;

//- (UIImage *)zj_imageByBlurRadius:(CGFloat)blurRadius
//                        tintColor:(nullable UIColor *)tintColor
//                         tintMode:(CGBlendMode)tintMode
//                       saturation:(CGFloat)saturation
//                        maskImage:(nullable UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
