//
//  UIImage+MKAdd.h
//  MKToolsKit
//
//  Created by xiaomk on 16/5/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <Accelerate/Accelerate.h>

@interface UIImage(MKAdd)
/** dataURL 转 图片 */
+ (UIImage *)mk_imageWithDataURL:(NSString *)imgSrc;

/** 返回九宫格图片 */
+ (UIImage *)mk_resizedImageWithName:(NSString *)name;

+ (UIImage *)mk_imageWithColor:(UIColor *)color;

- (UIImage *)mk_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
