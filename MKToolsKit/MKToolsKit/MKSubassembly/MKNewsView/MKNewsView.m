//
//  MKNewsView.m
//  Taoqicar
//
//  Created by xmk on 2017/1/10.
//  Copyright © 2017年 taoqicar. All rights reserved.
//

#import "MKNewsView.h"
#import "MKCategoryHead.h"

@interface MKNewsView (){
    
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *viewCurrent;
@property (nonatomic, strong) UIView *viewNext;

@property (nonatomic, strong) UIButton *btnText;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) MKIntegerBlock block;
@property (nonatomic, strong) NSMutableArray *textArray;

@property (nonatomic, assign) CGFloat imgWidth;
@end

@implementation MKNewsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        _textFont = [UIFont systemFontOfSize:12];
        _textColor = [UIColor whiteColor];
        _currentIndex = 0;
        _leftMarge = 8.0f;
        _rightMarge = 12.0f;
        _duration = 3.0f;
        _scrollTime = 1.0f;
        _imgWidth = 0.f;
    }
    return self;
}


- (void)setImageName:(NSString *)imgName width:(CGFloat)imgWidth{
    if (imgName && imgName.length > 0) {
        self.imgWidth = imgWidth;
        self.imageView.frame = CGRectMake(0, 0, imgWidth, self.bounds.size.height);
        self.imageView.image = [UIImage imageNamed:imgName];
    }else{
        self.imgWidth = 0.f;
        [_imageView removeFromSuperview];
        _imageView = nil;
    }
    if (self.textArray.count > 0) {
        NSArray *ary = [self.textArray copySelfPerfect];
        [self startPlayWithTextArray:ary block:self.block];
    }
}

- (void)startPlayWithTextArray:(NSArray *)array block:(MKIntegerBlock)block{
    if (array == nil || array.count == 0) {
        return;
    }
    //init
    [self.textArray removeAllObjects];
    [self.textArray addObjectsFromArray:array];
    self.block = block;
    _currentIndex = 0;

    //btn
    self.btnText.frame = CGRectMake(self.imgWidth,
                                    0,
                                    self.bounds.size.width-self.imgWidth,
                                    self.bounds.size.height);
    self.btnText.tag = 0;
    [self.btnText addTarget:self action:@selector(btnTextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnText];
    
    //view
    self.viewCurrent.frame = CGRectMake(self.imgWidth, 0, self.bounds.size.width-self.imgWidth,self.bounds.size.height);
    [self.viewCurrent removeAllSubviews];
    MKBlockExec(self.customViewBlock, self.viewCurrent);

    //lab
    UILabel *labCurrent = [[UILabel alloc] init];
    [self.viewCurrent addSubview:labCurrent];
    labCurrent.textColor = self.textColor;
    labCurrent.font = self.textFont;
    labCurrent.textAlignment = NSTextAlignmentLeft;
    labCurrent.tag = 100;
    
    labCurrent.frame = CGRectMake(self.leftMarge, 0,
                                  self.viewCurrent.width-(self.leftMarge+self.rightMarge),
                                  self.viewCurrent.height);
    labCurrent.text = self.textArray.firstObject;
    
    
    if (self.textArray.count > 1) {
        self.viewNext.frame = CGRectMake(self.imgWidth, self.bounds.size.height, self.bounds.size.width-self.imgWidth,self.bounds.size.height);
        [self.viewNext removeAllSubviews];
        MKBlockExec(self.customViewBlock, self.viewNext);

        UILabel *labNext = [[UILabel alloc] init];
        [self.viewNext addSubview:labNext];
        labNext.textColor = self.textColor;
        labNext.font = self.textFont;
        labNext.textAlignment = NSTextAlignmentLeft;
        labNext.tag = 100;
        
        labNext.frame = CGRectMake(self.leftMarge, 0,
                                        self.viewNext.width-(self.leftMarge+self.rightMarge),
                                        self.viewNext.height);
        labNext.text = [self.textArray objectAtIndex:1];
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(playNews) userInfo:nil repeats:YES];
        self.timer = [NSTimer timerWithTimeInterval:self.duration target:self selector:@selector(playNews) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)playNews{

    [UIView animateWithDuration:self.scrollTime animations:^{
        self.viewCurrent.y = - self.bounds.size.height;
        self.viewNext.y = 0;
    } completion:^(BOOL finished) {
        _currentIndex += 1;
        if (_currentIndex >= self.textArray.count) {
            _currentIndex = 0;
        }
        self.btnText.tag = _currentIndex;

        UIView *tmpView = self.viewCurrent;
        self.viewCurrent = self.viewNext;
        self.viewNext = tmpView;
        tmpView = nil;
        
        self.viewNext.y = self.bounds.size.height;
        NSInteger nextIndex = _currentIndex+1 >= self.textArray.count ? 0 : _currentIndex+1;
        UILabel *lab = [self.viewNext viewWithTag:100];
        if (lab) {
            lab.text = [self.textArray objectAtIndex:nextIndex];
        }
    }];
}

- (void)btnTextClick:(UIButton *)sender{
    MKBlockExec(self.block, sender.tag);
}

- (void)dealloc{
    DLog(@"dealloc");
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - ***** lazy *****
- (UIView *)viewCurrent{
    if (!_viewCurrent) {
        _viewCurrent = [UIView new];
        _viewCurrent.backgroundColor = [UIColor clearColor];
        [self addSubview:_viewCurrent];
    }
    return _viewCurrent;
}

- (UIView *)viewNext{
    if (!_viewNext) {
        _viewNext = [UIView new];
        _viewNext.backgroundColor = [UIColor clearColor];
        [self addSubview:_viewNext];
    }
    return _viewNext;
}

- (UIButton *)btnText{
    if (!_btnText) {
        _btnText = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btnText;
}

- (NSMutableArray *)textArray{
    if (!_textArray) {
        _textArray = @[].mutableCopy;
    }
    return _textArray;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
    }
    return _imageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
