//
//  MKNewsView.h
//  Taoqicar
//
//  Created by xmk on 2017/1/10.
//  Copyright © 2017年 taoqicar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKConst.h"

@interface MKNewsView : UIView

@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, assign) CGFloat leftMarge;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat scrollTime;
@property (nonatomic, assign, readonly) NSInteger currentIndex;

- (void)setImageName:(NSString *)imgName width:(CGFloat)imgWidth;
- (void)startPlayWithTextArray:(NSArray *)array block:(MKIntegerBlock)block;
@end
