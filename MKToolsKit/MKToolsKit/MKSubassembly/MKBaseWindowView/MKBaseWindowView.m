//
//  MKBaseWindowView.m
//  Taoqicar
//
//  Created by xmk on 2016/11/4.
//  Copyright © 2016年 taoqicar. All rights reserved.
//

#import "MKBaseWindowView.h"
#import "UIView+MKAdd.h"

@interface MKBaseWindowView()
@end

@implementation MKBaseWindowView



- (instancetype)initWithBlock:(MKBlock)block{
    if (self = [super initWithFrame:MKSCREEN_BOUNDS]) {
        self.block = block;
        self.backgroundColor = MKCOLOR_RGBA(0, 0, 0, 0.3);
        [self setupUI];
    }
    return self;
}

+ (id)viewWithNibBlock:(MKBlock)block{
    MKBaseWindowView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    view.frame = MKSCREEN_BOUNDS;
    view.block = block;
    view.backgroundColor = MKCOLOR_RGBA(0, 0, 0, 0.3);
    [view setupUI];
    return view;
}

- (void)setupUI{
    UIButton *btnBg = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBg.frame = self.bounds;
    [btnBg addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnBg];
    [self sendSubviewToBack:btnBg];
}

- (void)show{
    [self mk_showOnWindow];
}

- (void)hide{
    [self mk_removeFromWindow];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
