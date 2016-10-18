//
//  UINavigationController+MKAdd.h
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/9/21.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MKAdd)

/** pop 到制定界面 */
- (BOOL)popToViewControllerWitnName:(NSString *)vcName animated:(BOOL)animated;

/** 设置底部黑线 隐藏 */
- (void)setBottomLineHidden:(BOOL)hidden;

@end
