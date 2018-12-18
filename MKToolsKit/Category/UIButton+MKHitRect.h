//
//  UIButton+MKHitRect.h
//  MKToolsKit
//
//  Created by xiaomk on 2018/5/28.
//  Copyright © 2018年 mk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MKHitRect)

/**
 自定义响应边界 UIEdgeInsetsMake(-3, -4, -5, -6). 表示扩大
 例如： self.btn.hitEdgeInsets = UIEdgeInsetsMake(-3, -4, -5, -6);
 */
@property(nonatomic, assign) UIEdgeInsets mk_hitEdgeInsets;
@end
