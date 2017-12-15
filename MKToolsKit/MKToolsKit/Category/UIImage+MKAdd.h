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
+ (UIImage *)mk_imageWithQRString:(NSString *)qrStr
                         imgWidth:(CGFloat)imgWidth
                           margin:(CGFloat)margin
                             logo:(NSString *)logoImageName;

- (UIImage *)mk_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

- (BOOL)hasAlpha;
- (CGFloat)mk_imageLength;
/** 压缩图片 */
- (NSData *)mk_compressLessThan1M;
- (NSData *)mk_compressLessThan500KBData;
- (UIImage *)compressWithRatio:(CGFloat)ratio;
- (UIImage *)compressImage;

/** 剪裁图片 */
- (UIImage *)mk_cropWith:(CGRect)rect;

/** 修改图片尺寸 */
- (UIImage *)mk_imageByScalingToSize:(CGSize)targetSize;

- (UIImage *)mk_scaleToSize:(CGSize)size;
@end
