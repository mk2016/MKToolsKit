//
//  UIView+MKAdd.h
//  MKToolsKit
//
//  Created by xiaomk on 16/5/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
//    BorderDirectionTypeNone = 0,    //不显示边框
    MKBorderDirectionTypeNone       = 0,
    MKBorderDirectionTypeTop        = 1 << 1,   //显示上边框
    MKBorderDirectionTypeLeft       = 1 << 2,   //显示左边框
    MKBorderDirectionTypeBottom     = 1 << 3,   //显示下边框
    MKBorderDirectionTypeRight      = 1 << 4,   //显示右边框
    MKBorderDirectionTypeAll        = ~0UL
}MKBorderDirectionType;

@interface UIView(MKAdd)

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
- (void)mk_setCorner;
- (void)mk_setCornerValue:(CGFloat)value;
- (void)mk_setToCircle;
- (void)mk_setCornerWith:(UIRectCorner)corners radii:(CGSize)size;

#pragma mark - ***** 边框 ******
- (void)mk_setBorderColor:(UIColor *)color;
- (void)mk_setBorderWidth:(CGFloat)width andColor:(UIColor *)color;

- (void)mk_addBorderOnDirection:(MKBorderDirectionType)direction;
- (void)mk_addBorderOnDirection:(MKBorderDirectionType)direction borderWidth:(CGFloat)width borderColor:(UIColor *)color isConstraint:(BOOL)isConstraint;

- (void)mk_removeAllSubviews;
- (void)mk_showOnWindow;
- (void)mk_removeFromWindow;

#pragma mark - ***** screenshot ******
- (UIImage *)mk_screenshot;

@end
