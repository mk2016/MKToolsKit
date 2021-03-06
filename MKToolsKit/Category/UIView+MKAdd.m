//
//  UIView+MKAdd.m
//  MKToolsKit
//
//  Created by xiaomk on 16/5/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "UIView+MKAdd.h"
#import "MKConst.h"
#import "MKUITools.h"

@implementation UIView(MKAdd)

#pragma mark - ***** Frame ******
- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGSize)size{
    return self.frame.size;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)centerY{
    return self.center.y;
}


- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y;{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)x{
    CGPoint center = self.center;
    center.x = x;
    self.center = center;
}

- (void)setCenterY:(CGFloat)y{
    CGPoint center = self.center;
    center.y = y;
    self.center = center;
}

#pragma mark - ***** 圆角 ******
- (void)mk_setCorner{
    [self mk_setCornerValue:4.f];
}

- (void)mk_setCornerValue:(CGFloat)value{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = value;
}

- (void)mk_setToCircle{
    [self mk_setCornerWith:UIRectCornerAllCorners radii:CGSizeMake(self.width/2, 0)];
}

- (void)mk_setCornerWith:(UIRectCorner)corners radii:(CGSize)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
//    self.layer.cornerRadius = size.width;
//    self.layer.masksToBounds = YES;
//    self.layer.shouldRasterize = YES;
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

/** é´å½± */
- (void)mk_addShadowWithColor:(UIColor *)color{
    [self mk_addShadowWithColor:color size:CGSizeMake(0, 0)];
}

- (void)mk_addShadowWithColor:(UIColor *)color size:(CGSize)size{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = size;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1;
}


#pragma mark - ***** 边框 ******
- (void)mk_setBorderColor:(UIColor *)color{
    [self mk_setBorderWidth:0.7 andColor:color];
}

- (void)mk_setBorderWidth:(CGFloat)width andColor:(UIColor *)color{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void)mk_addBorderOnDirection:(MKBorderDirectionType)direction{
    [self mk_addBorderOnDirection:direction borderWidth:0.7 borderColor:[UIColor colorWithRed:(200/255.0f) green:(200/255.0f) blue:(200/255.0f) alpha:1] isConstraint:YES];
}

- (void)mk_addBorderOnDirection:(MKBorderDirectionType)direction borderWidth:(CGFloat)width borderColor:(UIColor *)color isConstraint:(BOOL)isConstraint{
    if (isConstraint) {
        [self layoutIfNeeded];  //约束生效
    }
    if (direction & MKBorderDirectionTypeTop) {
        [self addBorderWithFrame:CGRectMake(0, 0, self.frame.size.width, width) color:color];
    }
    if (direction & MKBorderDirectionTypeLeft){
        [self addBorderWithFrame:CGRectMake(0, 0, width, self.frame.size.height) color:color];
    }
    if (direction & MKBorderDirectionTypeBottom){
        [self addBorderWithFrame:CGRectMake(0, self.frame.size.height-width, self.frame.size.width, width) color:color];
    }
    if (direction & MKBorderDirectionTypeRight){
        [self addBorderWithFrame:CGRectMake(self.frame.size.width-width, 0, width, self.frame.size.height) color:color];
    }
}

- (void)addBorderWithFrame:(CGRect)frame color:(UIColor *)color{
    CALayer *borderLayer = [CALayer layer];
    borderLayer.frame = frame;
    borderLayer.backgroundColor = color.CGColor;
    [self.layer addSublayer:borderLayer];
}

#pragma mark - ***** remove ******
- (void)mk_removeAllSubviews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


- (void)mk_showOnWindow{
    UIWindow *window = [MKUITools getCurrentWindow];
    [window addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

- (void)mk_removeFromWindow{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - ***** screenshot ******
- (UIImage *)mk_screenshot{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        
        NSInvocation* invoc = [NSInvocation invocationWithMethodSignature:
                               [self methodSignatureForSelector:
                                @selector(drawViewHierarchyInRect:afterScreenUpdates:)]];
        [invoc setTarget:self];
        [invoc setSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)];
        CGRect arg2 = self.bounds;
        BOOL arg3 = YES;
        [invoc setArgument:&arg2 atIndex:2];
        [invoc setArgument:&arg3 atIndex:3];
        [invoc invoke];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
