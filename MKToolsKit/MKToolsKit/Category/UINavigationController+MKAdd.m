//
//  UINavigationController+MKAdd.m
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/9/21.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "UINavigationController+MKAdd.h"

@implementation UINavigationController (MKAdd)

/** pop 到制定界面 */
- (BOOL)popToViewControllerWitnName:(NSString *)vcName animated:(BOOL)animated{
    Class class = NSClassFromString(vcName);
    if (class) {
        for (UIViewController *vc in self.viewControllers) {
            if ([vc isKindOfClass:class]) {
                [self popToViewController:vc animated:animated];
                return YES;
            }
        }
    }
    return NO;
}

/** 设置底部黑线 隐藏 */
- (void)setBottomLineHidden:(BOOL)hidden{
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *array = self.navigationBar.subviews;
        for (id obj in array) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *viewBar = (UIView *)obj;
                NSArray *subViews = viewBar.subviews;
                for (id view in subViews) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        UIImageView *viewLine = (UIImageView*)view;
                        if (viewLine.bounds.size.height <= 1.0) {
                            viewLine.hidden = hidden;
                        }
                    }
                }
            }
        }
    }
}

@end
