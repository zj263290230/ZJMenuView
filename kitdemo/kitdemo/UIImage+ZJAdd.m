//
//  UIImage+ZJAdd.m
//  kitdemo
//
//  Created by zj on 2019/4/5.
//  Copyright © 2019 zj. All rights reserved.
//

#import "UIImage+ZJAdd.h"

@implementation UIImage (ZJAdd)
- (UIImage *)zj_imageByResizeToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)zj_imageByRoundCornerRadius:(CGFloat)radius
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(nullable UIColor *)borderColor {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, borderWidth)];
        
        [path closePath];
        path.lineWidth = borderWidth;
        path.lineJoinStyle = kCGLineJoinMiter;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}

+ (UIImage *)zj_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)zj_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize {
    size_t width = CGImageGetWidth(self.CGImage);
    size_t height = CGImageGetHeight(self.CGImage);
    CGRect newRect = CGRectApplyAffineTransform(CGRectMake(0, 0, width, height), fitSize ? CGAffineTransformMakeRotation(radians):CGAffineTransformIdentity);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, newRect.size.width, newRect.size.height, 8, newRect.size.width * 4, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    CGColorSpaceRelease(colorSpace);
    
    if (!context) {
        return nil;
    }
    
    CGContextSetShouldAntialias(context, true);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    CGContextTranslateCTM(context, +(newRect.size.width *0.5), +(newRect.size.height * 0.5));
    CGContextRotateCTM(context, radians);
    
    CGContextDrawImage(context, CGRectMake(-(width * 0.5), -(height * 0.5), width, height), self.CGImage);
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:imgRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imgRef);
    CGContextRelease(context);
    return img;
}


- (UIImage *)zj_imageByTintColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [color set];
    UIRectFill(rect);
    [self drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeDestinationIn alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//- (UIImage *)zj_imageByBlurRadius:(CGFloat)blurRadius
//                        tintColor:(nullable UIColor *)tintColor
//                         tintMode:(CGBlendMode)tintMode
//                       saturation:(CGFloat)saturation
//                        maskImage:(nullable UIImage *)maskImage {
//    
//}
@end
