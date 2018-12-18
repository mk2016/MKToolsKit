//
//  UITabBar+MKAdd.h
//  MKToolsKit
//
//  Created by xiaomk on 16/6/24.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar(MKAdd)

- (void)mk_setBadgeWithValue:(NSString *)value onIndex:(int)index;

- (void)mk_smallBadgeOnItemIndex:(int)index show:(BOOL)show;
/** show small badge */
- (void)mk_showSmallBadgeOnItemIndex:(int)index;

/** hide small badge */
- (void)mk_hideSmallBadgeOnItemIndex:(int)index;

/*!< remove all small badge */
- (void)mk_clearAllSmallBadge;

@end
