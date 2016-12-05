//
//  MKImageView.m
//  MKToolsKit
//
//  Created by xiaomk on 16/8/17.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "MKImageView.h"
#import "MKPictureBrowser.h"

@interface MKImageView ()<UIGestureRecognizerDelegate>{
}

@property (nonatomic, strong) UIButton *btn;
@end

@implementation MKImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:gesture];
        gesture.delegate = self;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:gesture];
        gesture.delegate = self;
    }
    return self;
}

- (void)tapGesture:(UITapGestureRecognizer *)sender{
    if (self) {
        [MKPictureBrowser showImage:self];
    }
}
@end
