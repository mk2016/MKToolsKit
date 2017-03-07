//
//  MKPictureBrowser.m
//  MKToolsKit
//
//  Created by xmk on 2016/10/31.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "MKPictureBrowser.h"
#import "MKUITools.h"

static CGRect oldframe;

@implementation MKPictureBrowser


+ (void)showImage:(UIImageView *)imageView{
    //图片
    UIImage *image = imageView.image;
    UIWindow *window = [MKUITools getCurrentWindow];
    
    //背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //原来的frame
    oldframe = [imageView convertRect:imageView.bounds toView:window];
    
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

+ (void)hideImage:(UITapGestureRecognizer *)tap{
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
