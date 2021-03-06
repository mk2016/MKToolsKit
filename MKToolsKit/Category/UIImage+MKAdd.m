//
//  UIImage+MKAdd.m
//  MKToolsKit
//
//  Created by xiaomk on 16/5/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "UIImage+MKAdd.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage(MKAdd)

+ (UIImage *)mk_imageWithDataURL:(NSString *)imgSrc{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgSrc]]];
    return image;
}

- (NSString *)mk_imageToDataURL{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    if ([self hasAlpha]) {
        imageData = UIImagePNGRepresentation(self);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(self, 1.0f);
        mimeType = @"image/jpeg";
    }
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType, [imageData base64EncodedStringWithOptions: 0]];
}

//CIImage -> UIImage
+ (UIImage *)mk_imageWithCIImage:(CIImage *)ciImage size:(CGSize)size{
    if (ciImage == nil) {
        return nil;
    }
    if (size.width == 0 ) {
        size = ciImage.extent.size;
    }
    UIGraphicsBeginImageContext(size);
    [[UIImage imageWithCIImage:ciImage
                         scale:1.f
                   orientation:UIImageOrientationUp] drawInRect:CGRectMake(0,0, size.width,size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



+ (UIImage *)mk_resizedImageWithName:(NSString *)name{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)mk_imageWithColor:(UIColor *)color{
    return [self mk_imageWithColor:color size:CGSizeMake(1.f, 1.f)];
}

+ (UIImage *)mk_imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}




- (UIImage *)mk_imageFillColor:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/** 生成二维码 */
+ (UIImage *)mk_imageWithQRString:(NSString *)str imgWidth:(CGFloat)imgWidth{
    return [self mk_imageWithQRString:str imgWidth:imgWidth margin:0 logo:nil];
}

+ (UIImage *)mk_imageWithQRString:(NSString *)qrStr imgWidth:(CGFloat)imgWidth margin:(CGFloat)margin logo:(NSString *)logoImageName{
    return [self mk_imageWithQRString:qrStr imgWidth:imgWidth margin:margin logo:logoImageName logoWidth:28];
}
    
+ (UIImage *)mk_imageWithQRString:(NSString *)qrStr imgWidth:(CGFloat)imgWidth margin:(CGFloat)margin logo:(NSString *)logoImageName logoWidth:(CGFloat)logoWidth{

    CGFloat qrImageW = imgWidth - margin*2;
    NSData *stringData = [qrStr dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [qrFilter setDefaults];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *ciImage = qrFilter.outputImage;
    
    CGRect extent = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(qrImageW/CGRectGetWidth(extent), qrImageW/CGRectGetHeight(extent));
    
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent)* scale;
    size_t height = CGRectGetHeight(extent)* scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGColorSpaceRelease(cs);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    UIImage *qrImage = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imgWidth, imgWidth), NO, [UIScreen mainScreen].scale);
    [qrImage drawInRect:CGRectMake(margin, margin, qrImageW, qrImageW)];
    if (logoImageName) {
        UIImage *logoImg = [UIImage imageNamed:logoImageName];
        CGFloat xyPostion = (imgWidth-logoWidth)/2.f;
        [logoImg drawInRect:CGRectMake(xyPostion, xyPostion, logoWidth, logoWidth)];
    }
    qrImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return qrImage;
}

- (UIImage *)mk_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (BOOL)hasAlpha{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

/** 压缩图片 */
- (NSData *)mk_compressLessThan1M{
    return [self mk_compressLessThan:1000.f];
}

- (NSData *)mk_compressLessThan500KBData{
    return [self mk_compressLessThan:500.f];
}

- (NSData *)mk_compressLessThan:(CGFloat)maxKB{
    NSData *imgData = UIImageJPEGRepresentation(self, 1.0);
    CGFloat sizeOriginKB = imgData.length / 1000.0f;
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxKB && resizeRate > 0.1) {
        imgData = UIImageJPEGRepresentation(self, resizeRate);
        sizeOriginKB = imgData.length/1000.f;
        resizeRate -= 0.1;
    }
    return imgData;
}

- (UIImage *)mk_compressWithRatio:(CGFloat)ratio{
    NSData *imgData = UIImageJPEGRepresentation(self, ratio);
    UIImage *result = [UIImage imageWithData:imgData];
    return result;
}

- (UIImage *)mk_compressImage{
    NSData *imgData = UIImageJPEGRepresentation(self, 1.0);
    CGFloat ratio = 1;
    if (imgData.length > 10000000) {
        ratio = 0.2;
    }else if (imgData.length > 5000000){
        ratio = 0.4;
    }else if (imgData.length > 3000000){
        ratio = 0.5;
    }else if (imgData.length > 2000000){
        ratio = 0.6;
    }else if (imgData.length > 1000000){
        ratio = 0.7;
    }
    imgData = UIImageJPEGRepresentation(self, ratio);
    UIImage *result = [UIImage imageWithData:imgData];
    return result;
}

- (CGFloat)mk_imageLength{
    NSData *data = UIImageJPEGRepresentation(self, 1);
    return data.length/1000.f;
}


- (UIImage *)mk_cropWith:(CGRect)rect{
    rect = CGRectMake(rect.origin.x * self.scale,
                      rect.origin.y * self.scale,
                      rect.size.width * self.scale,
                      rect.size.height * self.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}


- (UIImage *)mk_scaleToSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //Determine whether the screen is retina
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 3.0);
    } else{
        UIGraphicsBeginImageContext(size);
    }
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/** 获取视频第一帧图片 */
+ (UIImage *)mk_thumbnailImageWithVideo:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    return [self mk_thumbnailImageWithVideoURL:url];
}

+ (UIImage *)mk_thumbnailImageWithVideoURL:(NSURL *)videoURL{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    generator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CMTime time = CMTimeMake(1,60);
    CMTime actualTime;
    NSError *error = nil;
    CGImageRef imageRef = [generator copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if (!imageRef) {
        NSLog(@"thumbnailImageGenerationError %@", error);
    }
    UIImage *image = imageRef ? [[UIImage alloc] initWithCGImage:imageRef] : nil;
    CGImageRelease(imageRef);
    return image;
}
@end

