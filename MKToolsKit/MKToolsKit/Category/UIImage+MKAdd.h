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
/** 图片转 dataURL */
- (NSString *)mk_imageToDataURL;

/** 返回九宫格图片 */
+ (UIImage *)mk_resizedImageWithName:(NSString *)name;
/** 根据颜色生成图片 */
+ (UIImage *)mk_imageWithColor:(UIColor *)color;

/** 生成二维码图片 */
+ (UIImage *)mk_imageWithQRString:(NSString *)str imgWidth:(CGFloat)imgWidth;


- (UIImage *)mk_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

- (BOOL)hasAlpha;
/** 压缩图片 */
- (UIImage *)compressLessThan1M;
- (UIImage *)compressWithRatio:(CGFloat)ratio;
- (UIImage *)compressImage;



@end
