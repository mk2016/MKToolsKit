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
@property (nonatomic, weak) UILabel *labCurrent;
@property (nonatomic, weak) UILabel *labNext;
@property (nonatomic, strong) UIButton *btnText;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) MKIntegerBlock block;
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
        _duration = 3.0f;
        _scrollTime = 1.0f;
        _imgWidth = 0.f;
    }
    return self;
}

- (void)setImageName:(NSString *)imgName width:(CGFloat)imgWidth{
    self.imgWidth = imgWidth;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWidth, self.bounds.size.height)];
    [self addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:imgName];
    
    if (self.textArray.count > 0) {
        NSArray *ary = [self.textArray copySelfPerfect];
        [self startPlayWithTextArray:ary block:self.block];
    }
}

- (void)startPlayWithTextArray:(NSArray *)array block:(MKIntegerBlock)block{
    if (array == nil || array.count == 0) {
        return;
    }
    [self.textArray removeAllObjects];
    [self.textArray addObjectsFromArray:array];
    self.block = block;
    
    self.btnText.frame = CGRectMake(self.imgWidth,
                                    0,
                                    self.bounds.size.width-self.imgWidth,
                                    self.bounds.size.height);
    self.btnText.tag = 0;
    [self.btnText addTarget:self action:@selector(btnTextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnText];
    
    _currentIndex = 0;
    self.labCurrent.frame = CGRectMake(self.imgWidth+self.leftMarge, 0,
                                       self.bounds.size.width-(self.imgWidth+self.leftMarge-12),
                                       self.bounds.size.height);
    self.labCurrent.text = self.textArray.firstObject;
    
    if (self.textArray.count > 1) {
        self.labNext.frame = CGRectMake(self.imgWidth+self.leftMarge,
                                        self.bounds.size.height,
                                        self.bounds.size.width-(self.imgWidth+self.leftMarge-12),
                                        self.bounds.size.height);
        self.labNext.text = [self.textArray objectAtIndex:1];
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(playNews) userInfo:nil repeats:YES];
    }
}

- (void)playNews{

    [UIView animateWithDuration:self.scrollTime animations:^{
        self.labCurrent.y = - self.bounds.size.height;
        self.labNext.y = 0;
    } completion:^(BOOL finished) {
        _currentIndex += 1;
        if (_currentIndex >= self.textArray.count) {
            _currentIndex = 0;
        }
        self.btnText.tag = _currentIndex;

        UILabel *tmpLab = self.labCurrent;
        self.labCurrent = self.labNext;
        self.labNext = tmpLab;
        tmpLab = nil;
        
        self.labNext.y = self.bounds.size.height;
        NSInteger nextIndex = _currentIndex+1 >= self.textArray.count ? 0 : _currentIndex+1;
        self.labNext.text = [self.textArray objectAtIndex:nextIndex];
    
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
- (UILabel *)labCurrent{
    if (!_labCurrent) {
        UILabel *lab = [[UILabel alloc] init];
        _labCurrent = lab;
        _labCurrent.textColor = self.textColor;
        _labCurrent.font = self.textFont;
        _labCurrent.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_labCurrent];
    }
    return _labCurrent;
}

- (UILabel *)labNext{
    if (!_labNext) {
        UILabel *lab = [[UILabel alloc] init];
        _labNext = lab;
        _labNext.textColor = self.textColor;
        _labNext.font = self.textFont;
        _labNext.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_labNext];
    }
    return _labNext;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
