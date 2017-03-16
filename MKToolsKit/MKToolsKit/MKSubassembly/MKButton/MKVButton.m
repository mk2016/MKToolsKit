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

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
        self.space = 4;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
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
