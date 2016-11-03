//
//  UIAlertView+MKAdd.h
//  MKToolsKit
//
//  Created by xiaomk on 16/9/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (MKAdd)

- (void)showWithBlock:(void(^)(NSInteger buttonIndex))block;

@end
