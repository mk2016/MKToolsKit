//
//  MKVButton.m
//  MKToolsKit
//
//  Created by xiaomk on 16/5/27.
//  Copyright © 2016年 tianchuang. All rights reserved.
//

#import "MKVButton.h"

@interface MKVButton(){
    
}

@end

@implementation MKVButton

///** 控制label显示在哪和大小 */
//- (CGRect)titleRectForContentRect:(CGRect)contentRect{
//    return CGRectMake(0, contentRect.size.width, contentRect.size.width, contentRect.size.height - contentRect.size.width);
//}
//
///** 控制image显示在哪和大小 */
//- (CGRect)imageRectForContentRect: (CGRect)contentRect{ //
//    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
//}
//
//// 我们也可以在initWithFrame:方法中设置UIButton的内部控件的属性
//- (instancetype)initWithFrame: (CGRect)frame{
//    if (self = [super initWithFrame: frame]) {
//        self.titleLabel.backgroundColor = [UIColor blueColor];
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.imageView.backgroundColor = [UIColor yellowColor];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
        self.space = 4;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGRect imageRect = [self imageRectForContentRect:contentRect];
    CGRect titleRect = [self titleRectForContentRect:contentRect];
    
    CGFloat heightAll = imageRect.size.height + titleRect.size.height + self.space;
    
    CGPoint imageNew;
    imageNew.x = (contentRect.size.width - imageRect.size.width)/2;
    imageNew.y = (contentRect.size.height - heightAll)/2;
    
    self.imageView.frame = CGRectMake(imageNew.x, imageNew.y ,imageRect.size.width, imageRect.size.height);
    
    
    CGPoint titleNew;
    titleNew.x = (contentRect.size.width - titleRect.size.width)/2;
    titleNew.y = (contentRect.size.height + heightAll)/2 - titleRect.size.height;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = CGRectMake(4, titleNew.y, contentRect.size.width-8, titleRect.size.height);
}

@end
