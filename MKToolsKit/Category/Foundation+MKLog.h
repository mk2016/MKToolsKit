//
//  Foundation+MKLog.h
//  MKToolsKit
//
//  Created by xiaomk on 16/5/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(MKLog)
+ (NSString *)searchAllSubviews:(UIView *)superview;
- (NSString *)description;
@end

@interface NSDictionary(MKLog)
- (NSString *)descriptionWithLocale:(id)locale;
@end

@interface NSArray(MKLog)
- (NSString *)descriptionWithLocale:(id)locale;
@end
