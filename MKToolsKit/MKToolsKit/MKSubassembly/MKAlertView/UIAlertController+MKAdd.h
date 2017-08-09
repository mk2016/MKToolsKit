/** 
 MIT License
 
 Copyright (c) 2017 MK Shaw <xiaomk7758@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

//
//  UIAlertController+MKAdd.h
//  MKAlertView
//
//  Created by xmk on 2017/6/16.
//  Copyright © 2017年 mk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKAlertCtrlConfig;
@interface UIAlertController (MKAdd)

#pragma mark - ***** system style *****
+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                   preferredStyle:(UIAlertControllerStyle)style
                            block:(void (^)(NSInteger buttonIndex))block
                     buttonTitles:(NSString *)cancelTitle, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                      cancelTitle:(NSString *)cancelTitle
                     confirmTitle:(NSString *)confirmTitle
                   preferredStyle:(UIAlertControllerStyle)style
                            block:(void (^)(NSInteger buttonIndex))block;

+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                     buttonTitles:(NSArray *)buttonTitles
                   preferredStyle:(UIAlertControllerStyle)style
                            block:(void (^)(NSInteger buttonIndex))block;


#pragma mark - ***** custom style *****
+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                   preferredStyle:(UIAlertControllerStyle)style
                           config:(MKAlertCtrlConfig *)config
                            block:(void (^)(NSInteger buttonIndex))block
                     buttonTitles:(NSString *)cancelTitle, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                      cancelTitle:(NSString *)cancelTitle
                     confirmTitle:(NSString *)confirmTitle
                   preferredStyle:(UIAlertControllerStyle)style
                           config:(MKAlertCtrlConfig *)config
                            block:(void (^)(NSInteger buttonIndex))block;

+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                     buttonTitles:(NSArray *)buttonTitles
                   preferredStyle:(UIAlertControllerStyle)style
                           config:(MKAlertCtrlConfig *)config
                            block:(void (^)(NSInteger buttonIndex))block;

/** setup UI with config */
- (void)mk_setCustomStyleWith:(MKAlertCtrlConfig *)config;
@end



@interface MKAlertCtrlConfig : NSObject
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) NSTextAlignment titleAlignment;
@property (nonatomic, strong) UIFont *messageFont;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, assign) NSTextAlignment messageAlignment;
@property (nonatomic, strong) UIColor *actionColor;
@property (nonatomic, assign) NSInteger cancelIndex;
@property (nonatomic, assign) NSInteger destructiveIndex;
@property (nonatomic, strong) UIColor *destructiveColor;
@end
