//
//  UIImageView+MKTapAdd.m
//  MKToolsKit
//
//  Created by xmk on 2017/5/24.
//  Copyright © 2017年 mk. All rights reserved.
//

#import "UIImageView+MKTapAdd.h"
#import <objc/runtime.h>

@implementation UIImageView (MKTapAdd)

- (BOOL)mk_tapPreview{
    NSNumber *tapPreview = objc_getAssociatedObject(self, @selector(mk_tapPreview));
    return [tapPreview boolValue];
}

- (void)setMk_tapPreview:(BOOL)mk_tapPreview{
    objc_setAssociatedObject(self, @selector(mk_tapPreview), @(mk_tapPreview), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setUserInteractionEnabled:mk_tapPreview];
    if (mk_tapPreview) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:gesture];
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)sender{
    if (self) {
        [self mk_previewImageView];
    }
}

static CGRect oldframe;
- (void)mk_previewImageView{
    //图片
    UIImage *image = self.image;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    //背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //原来的frame
    oldframe = [self convertRect:self.bounds toView:window];
    
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:oldframe];
    imageV.image = image;
    imageV.tag = 1;
    [backgroundView addSubview:imageV];
    [window addSubview:backgroundView];
    //隐藏手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageV.frame = CGRectMake(0,
                                  ([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2,
                                  [UIScreen mainScreen].bounds.size.width,
                                  image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideImage:(UITapGestureRecognizer *)tap{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
