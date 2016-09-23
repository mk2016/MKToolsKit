//
//  UIView+MKExtension.h
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/5/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
//    BorderDirectionTypeNone = 0,    //不显示边框
    MKBorderDirectionTypeTop      = 1 << 0,   //显示上边框
    MKBorderDirectionTypeLeft     = 1 << 1,   //显示左边框
    MKBorderDirectionTypeBottom   = 1 << 2,   //显示下边框
    MKBorderDirectionTypeRight    = 1 << 3,   //显示右边框
    MKBorderDirectionTypeAll      = ~0UL
}MKBorderDirectionType;

@interface UIView(MKExtension)

- (CGFloat)x;
- (CGFloat)y;

- (CGFloat)width;
- (CGFloat)height;

- (CGSize)size;
- (CGPoint)origin;

- (CGFloat)centerX;
- (CGFloat)centerY;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (void)setSize:(CGSize)size;

- (void)setCenterX:(CGFloat)x;
- (void)setCenterY:(CGFloat)y;

#pragma mark - ***** 圆角 ******
- (void)setCornerValue:(CGFloat)value;
- (void)setCorner;
- (void)setToCircle;
- (void)setCornerWithCorners:(UIRectCorner)corners cornerRadii:(CGSize)size;

#pragma mark - ***** 边框 ******
- (void)setBorder;
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor*)color;
- (void)setBorderColor:(UIColor*)color;

- (void)addBorderOnDirection:(MKBorderDirectionType)direction;
- (void)addBorderOnDirection:(MKBorderDirectionType)direction borderWidth:(CGFloat)width borderColor:(UIColor *)color isConstraint:(BOOL)isConstraint;



- (void)removeAllSubviews;


- (UIImage *)mk_screenshot;


@end
