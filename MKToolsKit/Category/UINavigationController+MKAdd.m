//
//  UINavigationController+MKAdd.m
//  MKToolsKit
//
//  Created by xiaomk on 16/9/21.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "UINavigationController+MKAdd.h"
#import "MKCategoryHead.h"

@implementation UINavigationController (MKAdd)

/** pop 到制定界面 */
- (BOOL)mk_popToViewControllerWithName:(NSString *)vcName animated:(BOOL)animated{
    Class class = NSClassFromString(vcName);
    if (class) {
        for (UIViewController *vc in self.viewControllers) {
            if ([vc isKindOfClass:class]) {
                [self popToViewController:vc animated:animated];
                return YES;
            }
        }
    }
    [self popViewControllerAnimated:YES];
    return NO;
}

/** 设置底部黑线 隐藏 */
- (void)mk_setBottomLineHidden:(BOOL)hidden{
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

+ (void)mk_hiddenBottomLine{
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]){
        [[UINavigationBar appearance] setShadowImage:[UIImage mk_imageWithColor:[UIColor clearColor]]];
    }
}

/** 设置不透明的颜色背景图 */
- (void)setBackgroundOpacityColor:(UIColor *)color{
    UIImage *img = [UIImage mk_imageWithColor:color];
    [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
}

/** 自定义底部 线条 */
- (void)setCustomNavigationBarBottomLineWithImageName:(NSString *)imageName hidden:(BOOL)hidden{
    UIImageView *img = [self.navigationBar viewWithTag:888];
    if (!img) {
        img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1)];
        img.image = [UIImage imageNamed:imageName];
        img.tag = 888;
        [self.navigationBar addSubview:img];
    }
    img.hidden = hidden;
}
@end
