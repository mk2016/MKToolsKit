//
//  UIAlertView+MKExtension.m
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/9/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <objc/runtime.h>
#import "UIAlertView+MKExtension.h"

@implementation UIAlertView (MKExtension)

static char key;

- (void)showWithBlock:(void (^)(NSInteger))block{
    if (block) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY);
        self.delegate = self;
    }
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    void(^block)(NSInteger buttonIndex);
    block = objc_getAssociatedObject(self, &key);
    objc_removeAssociatedObjects(self);
    if (block) {
        block(buttonIndex);
    }
}

@end
