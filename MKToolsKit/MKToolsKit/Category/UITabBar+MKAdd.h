//
//  UITabBar+MKAdd.h
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/6/24.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar(MKExtension)


/** show small badge */
- (void)showSmallBadgeOnItemIndex:(int)index;

/** hide small badge */
- (void)hideSmallBadgeOnItemIndex:(int)index;

/*!< remove all small badge */
- (void)clearAllSmallBadge;

@end
