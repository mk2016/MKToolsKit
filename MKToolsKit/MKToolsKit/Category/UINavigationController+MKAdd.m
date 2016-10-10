//
//  UINavigationController+MKAdd.m
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/9/21.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "UINavigationController+MKAdd.h"

@implementation UINavigationController (MKExtension)

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

@end
