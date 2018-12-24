//
//  UITextField+MKAdd.m
//  MKToolsKit
//
//  Created by xmk on 2017/4/8.
//  Copyright © 2017年 mk. All rights reserved.
//

#import "UITextField+MKAdd.h"

@implementation UITextField (MKAdd)

- (void)mk_constraintMoneyByIntegerLimit:(NSInteger)length{
    if (self.text.length > 1) {
        NSString *frist = [self.text substringToIndex:1];
        NSString *second = [self.text substringWithRange:NSMakeRange(1, 1)];
        if ([frist isEqualToString:@"0"] && ![second isEqualToString:@"."]) {
            self.text = [self.text substringWithRange:NSMakeRange(1, self.text.length-1)];
        }
    }
    
    NSRange range = [self.text rangeOfString:@"."];
    if (range.location != NSNotFound) { // 有小数点
        if (self.text.length == 1) {
            self.text = @"0.";
            return;
        }
        if (self.text.length > range.location+1) {
            NSString *lastStr = [self.text substringFromIndex:self.text.length-1];
            if ([lastStr isEqualToString:@"."]) {
                self.text = [self.text substringToIndex:self.text.length-1];
            }
        }
        
        if (length > 0) {
            if (self.text.length > length + 3) {
                self.text = [self.text substringToIndex:length + 3];
            }
        }
        
        if (range.location < self.text.length - 2) {
            self.text = [self.text substringToIndex:range.location + 3];
        }
        self.text = [self.text stringByReplacingOccurrencesOfString:@".." withString:@"."];
        if ([self.text rangeOfString:@"."].location == 0) {
            self.text = [self.text stringByReplacingOccurrencesOfString:@"." withString:@""];
        }
    } else { // 没有小数点
        if (length > 0) {
            if (self.text.length > length) {
                self.text = [self.text substringToIndex:length];
            }
        }
    }
}
@end
