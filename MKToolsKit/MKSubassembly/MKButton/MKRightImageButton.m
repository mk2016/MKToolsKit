//
//  MKRightImageButton.m
//  MKToolsKit
//
//  Created by xiaomk on 15/9/15.
//  Copyright (c) 2015年 mk. All rights reserved.
//

#import "MKRightImageButton.h"

@implementation MKRightImageButton


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 计算标题实际尺寸
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    NSMutableDictionary *attrDic = [NSMutableDictionary dictionary];
    attrDic[NSFontAttributeName] = self.titleLabel.font;
    CGRect titleRect = [self.currentTitle boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil];
    
    // 图片宽高
    CGFloat imageW = self.imageView.frame.size.width;
    CGFloat imageH = self.imageView.frame.size.height;
    
    // 标题宽高
    CGFloat titleW = titleRect.size.width;
    CGFloat titleH = titleRect.size.height;
    
    // 按钮宽高
    CGFloat btnH = self.frame.size.height;
    CGFloat btnW = self.frame.size.width;
    
    if (self.resizeButton) { // 重置按钮尺寸
        CGRect frame = self.frame;
        btnH = titleH > imageH ? titleH : imageH;
        btnW = titleW + imageW + self.marginBetweenTitleAndImage;
        self.frame = frame;
    }
    
    // 标题位置
    CGFloat titleX = (btnW - titleW - imageW - self.marginBetweenTitleAndImage) * 0.5;
    CGFloat titleY = (btnH - titleH) * 0.5;
    
    // 图片位置
    CGFloat imageX = titleX + titleW + self.marginBetweenTitleAndImage;
    CGFloat imageY = (btnH - imageH) * 0.5;
    
    // 设置标题及图片frame
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
}

- (void)setMarginBetweenTitleAndImage:(CGFloat)marginBetweenTitleAndImage{
    _marginBetweenTitleAndImage = marginBetweenTitleAndImage;
    [self setNeedsLayout];
}


@end
