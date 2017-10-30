//
//  MKDatePickerView.m
//  Cheyoubang
//
//  Created by xmk on 2016/11/8.
//  Copyright © 2016年 cyb. All rights reserved.
//

#import "MKDatePickerView.h"
#import "MKConst.h"
#import "MKUITools.h"

@interface MKDatePickerView()
@property (nonatomic, strong) UIView *shadeView;
@property (nonatomic, strong) UIView *sheetView;
@property (nonatomic, assign) CGFloat sheetViewH;
@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation MKDatePickerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.sheetViewH = 240;
        self.currentDate = [NSDate date];
        self.tintColor = MK_COLOR_RGB(0, 118, 255);
        self.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    }
    return self;
}

- (void)showWithBlock:(MKDatePickerViewBlock)block{
    self.block = block;
    self.frame = MK_SCREEN_BOUNDS;
    [self addSubview:self.shadeView];
    [self addSubview:self.sheetView];
    
    self.sheetView.frame = CGRectMake(0, MK_SCREEN_HEIGHT, MK_SCREEN_WIDTH, self.sheetViewH);
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MK_SCREEN_WIDTH, 40)];
    btnView.backgroundColor = MK_COLOR_RGB(240, 240, 240);
    [self.sheetView addSubview:btnView];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:self.tintColor forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:16];
    btnCancel.frame = CGRectMake(0, 0, 80, 40);
    [btnCancel addTarget:self action:@selector(btnCancelOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:btnCancel];
    
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
    [btnConfirm setTitleColor:self.tintColor forState:UIControlStateNormal];
    btnConfirm.titleLabel.font = [UIFont systemFontOfSize:16];
    btnConfirm.frame = CGRectMake(MK_SCREEN_WIDTH-80, 0, 80, 40);
    [btnConfirm addTarget:self action:@selector(btnConfirmOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:btnConfirm];
    
    self.datePicker.frame = CGRectMake(0, 40, MK_SCREEN_WIDTH, 200);
    self.datePicker.datePickerMode = self.datePickerModel;
    self.datePicker.timeZone = self.timeZone;
    self.datePicker.minimumDate = self.minimumDate;
    self.datePicker.maximumDate = self.maximumDate;
    self.datePicker.date = self.currentDate;
    [self.sheetView addSubview:self.datePicker];
    
    [[MKUITools getCurrentWindow] addSubview:self];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.shadeView setAlpha:0.2];
        [self.shadeView setUserInteractionEnabled:YES];
        
        CGRect frame = self.sheetView.frame;
        frame.origin.y = MK_SCREEN_HEIGHT - frame.size.height;
        self.sheetView.frame = frame;
    } completion:nil];
}

- (void)dismiss{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.shadeView setAlpha:0];
        [self.shadeView setUserInteractionEnabled:NO];
        
        CGRect frame = self.shadeView.frame;
        frame.origin.y = MK_SCREEN_HEIGHT;
        self.sheetView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - ***** 按钮事件 *****
- (void)btnConfirmOnclick:(UIButton *)sender{
    NSDate *date = self.datePicker.date;
    MK_BLOCK_EXEC(self.block, self, date);
    [self dismiss];
}

- (void)btnCancelOnclick:(UIButton *)sender{
    [self dismiss];
}

#pragma mark - ***** lazy *****
- (UIView *)shadeView{
    if (!_shadeView) {
        _shadeView = [[UIView alloc] init];
        [_shadeView setFrame:MK_SCREEN_BOUNDS];
        [_shadeView setBackgroundColor:MK_COLOR_RGBA(0, 0, 0, 1)];
        [_shadeView setUserInteractionEnabled:NO];
        [_shadeView setAlpha:0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_shadeView addGestureRecognizer:tap];
    }
    return _shadeView;
}

- (UIView *)sheetView{
    if (!_sheetView) {
        _sheetView = [[UIView alloc] init];
        [_sheetView setBackgroundColor:[UIColor whiteColor]];
    }
    return _sheetView;
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
    }
    return _datePicker;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
