//
//  MKConst.h
//  MKToolsKit
//
//  Created by xmk on 2016/10/31.
//  Copyright © 2016年 mk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 日志 */
#ifdef DEBUG
#   define DLog(...) NSLog(@"%s, %d, %@", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#   define ELog(fmt, ...) NSLog((@"[Elog] " fmt), ##__VA_ARGS__);
#   define MK_DEBUG_STATUS YES
#else
#   define DLog(...)
#   define ELog(...)
#   define MK_DEBUG_STATUS NO
#endif

/** 系统单例 简写 */

#define MK_APPLICATION      [UIApplication sharedApplication]
#define MK_NOTIFICATION     [NSNotificationCenter defaultCenter]
#define MK_USERDEFAULTS     [NSUserDefaults standardUserDefaults]
#define MK_FILEMANAGER      [NSFileManager defaultManager]

/** 屏幕尺寸 */
#define MK_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define MK_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define MK_SCREEN_SIZE      [UIScreen mainScreen].bounds.size
#define MK_SCREEN_BOUNDS    [UIScreen mainScreen].bounds
#define MK_SCREEN_CENTER    CGPointMake(MK_SCREEN_WIDTH/2, MK_SCREEN_HEIGHT/2);

#define MK_IS_IPHONE        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define MK_IS_PAD           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define MK_IS_IPHONE_X_XS   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
                                CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define MK_IS_IPHONE_XSMAX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
                                CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define MK_IS_IPHONE_XR     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
                                CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define MK_IS_IPHONE_XX     MK_IS_IPHONE_X_XS || MK_IS_IPHONE_XSMAX || MK_IS_IPHONE_XR

#define MK_IS_IPHONE_5      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
                                CGSizeEqualToSize(CGSizeMake(640, 1136),  [[UIScreen mainScreen] currentMode].size) : NO)
#define MK_IS_IPHONE_6      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
                                CGSizeEqualToSize(CGSizeMake(750, 1334),  [[UIScreen mainScreen] currentMode].size) : NO)
#define MK_IS_IPHONE_6Plus  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
                                CGSizeEqualToSize(CGSizeMeke(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define MK_STATUSBAR_HEIGHT             (MK_IS_IPHONE_XX ? 44 : 20)
#define MK_SCREEN_IPHONEX_IGNORE_HEIGHT (MK_IS_IPHONE_XX ? 24+34 : 0)
#define MK_SCREEN_IPHONEX_NAVGATION     (MK_IS_IPHONE_XX ? 88 : 64)
#define MK_SCREEN_IPHONEX_TOP           (MK_IS_IPHONE_XX ? 44 : 0)
#define MK_SCREEN_IPHONEX_BOTTOM        (MK_IS_IPHONE_XX ? 34 : 0)
#define MK_SCREEN_SAFE_HEIGHT           (MK_SCREEN_HEIGHT - MK_SCREEN_IPHONEX_TOP - MK_SCREEN_IPHONEX_BOTTOM)
#define MK_SCREEN_MAIN_HEIGHT           (MK_SCREEN_HEIGHT - MK_SCREEN_IPHONEX_NAVGATION - MK_SCREEN_IPHONEX_BOTTOM)
//#define MK_SCREEN_SAFE_FRAME            CGRectMake(0, MK_SCREEN_IPHONEX_NAVGATION, MK_SCREEN_WIDTH, MK_SCREEN_MAIN_HEIGHT)

#define MK_ONE_PIXEL_HEIGHT             (1.f/[UIScreen mainScreen].scale)
#define IPHONEX_HEAD_MARGIN             (MK_IS_IPHONE_XX ? 24 : 0)

/** 颜色 */
#define MK_COLOR_RGB(r, g, b)        [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]
#define MK_COLOR_RGBA(r, g, b, a)    [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:(a)]
#define MK_COLOR_HEX(rgbValue)       [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f \
                                                    green:((float)((rgbValue & 0xFF00) >> 8))/255.0f \
                                                     blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0f]

/** Font */
#define MK_FONT(a)          [UIFont systemFontOfSize:a]
#define MK_FONTBOLD(a)      [UIFont boldSystemFontOfSize:a]

#define MK_FONT_PFSC_Regular(a) [MKDeviceHelper systemIs9Later]?[UIFont fontWithName:@"PingFangSC-Regular" size:a]:[UIFont systemFontOfSize:a]
#define MK_FONT_PFSC_Light(a)   [MKDeviceHelper systemIs9Later]?[UIFont fontWithName:@"PingFangSC-Light" size:a]:[UIFont systemFontOfSize:a]
#define MK_FONT_PFSC_Medium(a)  [MKDeviceHelper systemIs9Later]?[UIFont fontWithName:@"PingFangSC-Medium" size:a]:[UIFont boldSystemFontOfSize:a]

/** 单例 */
#define MK_INSTANCETYPE + (instancetype)sharedInstance;

#define MK_IMPL_SHAREDINSTANCE(type)\
static type *sharedInstance = nil;\
+ (instancetype)sharedInstance {\
    static dispatch_once_t once;\
    dispatch_once(&once, ^{\
        sharedInstance = [[self alloc] init];\
    });\
    return sharedInstance;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
    static dispatch_once_t once;\
    dispatch_once(&once, ^{\
        sharedInstance = [super allocWithZone:zone];\
    });\
    return sharedInstance;\
}

/** 线程 */
#define MK_DISPATCH_MAIN_SYNC_SAFE(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_sync(dispatch_get_main_queue(), block);\
    }

#define MK_DISPATCH_MAIN_ASYNC_SAFE(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }

/** 弱引用 */
#define MK_WEAK_SELF          __weak typeof(self) weakSelf = self;
#define MK_WEAK_IFY(var)      __weak typeof(var) weak_##var = var;
#define MK_STRONG_SELF        __strong typeof(weakSelf) strongSelf = weakSelf;
#define MK_STRONG_IFY(var)    __strong typeof(var) strong_##var = var;

/** block */
#define MK_BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };
typedef void (^MKBlock)(id result);
typedef void (^MKBoolBlock)(BOOL bRet);
typedef void (^MKVoidBlock)(void);
typedef void (^MKIntegerBlock)(NSInteger index);
typedef void (^MKArrayBlock)(NSArray *array);

/** 处理分割线没在最左边问题：ios8以后才有的问题 */
#define MK_ADD_TABLEVIEW_SEPARATOR_ADJUST \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {\
        [tableView setSeparatorInset:UIEdgeInsetsZero];\
    }\
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {\
        [tableView setLayoutMargins:UIEdgeInsetsZero];\
    }\
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {\
        [cell setLayoutMargins:UIEdgeInsetsZero];\
    }\
}

#define  MK_ADJUSTS_SCROLLVIEW_INSETS_NO(scrollView,vc)\
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
        [scrollView performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
    } else {\
        vc.automaticallyAdjustsScrollViewInsets = NO;\
    }\
    _Pragma("clang diagnostic pop") \
} while (0)



#pragma mark - ***** 枚举 *****
/** tableView 上下拉 刷新 */
typedef enum {
    MKTableViewRefreshTypeNone      = 0,            /*!< 不添加刷新 */
    MKTableViewRefreshTypeHeader    = 1 << 1,       /*!< 头部 */
    MKTableViewRefreshTypeFooter    = 1 << 2,       /*!< 尾部 */
    MKTableViewRefreshTypeAll       = ~0UL
}MKTableViewRefreshType;

