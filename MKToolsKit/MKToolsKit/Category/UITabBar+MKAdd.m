//
//  UITabBar+MKAdd.m
//  MKToolsKit
//
//  Created by xiaomk on 16/6/24.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "UITabBar+MKAdd.h"

#define MKUITabBarTagBase 900

@implementation UITabBar(MKAdd)


- (void)mk_setBadgeWithValue:(NSString *)value onIndex:(int)index{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (index < self.items.count) {
            UITabBarItem *item = [self.items objectAtIndex:index];
            item.badgeValue = value;
        }
    });
}



/** 显示小红点 */
- (void)mk_showSmallBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = MKUITabBarTagBase + index;
    badgeView.layer.cornerRadius = 5;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / self.items.count;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);//圆形大小为10
    [self addSubview:badgeView];
}


/** 隐藏小红点 */
- (void)mk_hideSmallBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}

/** 清除所有小红点 */
- (void)mk_clearAllSmallBadge{
    for (UIView *view in self.subviews) {
        NSInteger tag = view.tag;
        if (tag >= MKUITabBarTagBase && tag <= MKUITabBarTagBase + 10) {
            [view removeFromSuperview];
        }
    }
}

//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    for (UIView *subView in self.subviews) {
        if (subView.tag == MKUITabBarTagBase + index) {
            [subView removeFromSuperview];
        }
    }
}

@end
