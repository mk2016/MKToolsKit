//
//  UINavigationController+MKAdd.h
//  MKToolsKit
//
//  Created by xiaomk on 16/9/21.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MKAdd)

/** pop 到制定界面 */
- (BOOL)mk_popToViewControllerWithName:(NSString *)vcName animated:(BOOL)animated;

/** 设置底部黑线 隐藏 */
- (void)mk_setBottomLineHidden:(BOOL)hidden;

@end
