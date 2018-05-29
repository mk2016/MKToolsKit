//
//  UIButton+MKHitRect.m
//  MKToolsKit
//
//  Created by xiaomk on 2018/5/28.
//  Copyright © 2018年 mk. All rights reserved.
//

#import "UIButton+MKHitRect.h"
#import <objc/runtime.h>

static const char * kHitEdgeInsets = "hitEdgeInsets";

@implementation UIButton (MKHitRect)

- (void)setMk_hitEdgeInsets:(UIEdgeInsets)mk_hitEdgeInsets{
    NSValue *value = [NSValue value:&mk_hitEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, kHitEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)mk_hitEdgeInsets{
    NSValue *value = objc_getAssociatedObject(self, kHitEdgeInsets);
    UIEdgeInsets edgeInsets;
    [value getValue:&edgeInsets];
    return value ? edgeInsets : UIEdgeInsetsZero;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (UIEdgeInsetsEqualToEdgeInsets(self.mk_hitEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden || self.alpha == 0) {
        return [super pointInside:point withEvent:event];
    }else{
        CGRect relativeFrame = self.bounds;
        CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.mk_hitEdgeInsets);
        return CGRectContainsPoint(hitFrame, point);
    }
}

@end
