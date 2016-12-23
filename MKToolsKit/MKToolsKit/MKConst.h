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
#   define DebugStatus YES
#else
#   define DLog(...)
#   define ELog(...)
#   define DebugStatus NO
#endif

/** 系统单例 简写 */
#define MKApplication       [UIApplication sharedApplication]
#define MKNotification      [NSNotificationCenter defaultCenter]
#define MKUserDefaults      [NSUserDefaults standardUserDefaults]
#define MKFileManager       [NSFileManager defaultManager]

/** 屏幕尺寸 */
#define MKSCREEN_WIDTH      [UIScreen mainScreen].bounds.size.width
#define MKSCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define MKSCREEN_SIZE       [UIScreen mainScreen].bounds.size
#define MKSCREEN_BOUNDS     [UIScreen mainScreen].bounds

/** 颜色 */
#define MKCOLOR_RGB(r, g, b)        [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]
#define MKCOLOR_RGBA(r, g, b, a)    [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:(a)]
#define MKCOLOR_HEX(rgbValue)       [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0f \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0f]

/** 单例 */
#define MKImpl_sharedInstance(type) + (instancetype)sharedInstance {\
static type *sharedInstance = nil;\
static dispatch_once_t once;\
dispatch_once(&once, ^{\
sharedInstance = [[self alloc] init];\
});\
return sharedInstance;}

/** 线程 */
#define MKDispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define MKDispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

/** 弱引用 */
#define MKWEAKSELF      __weak typeof(self) weakSelf = self;
#define MKSTRONGSELF    __strong typeof(weakSelf) strongSelf = weakSelf;
#define MKWEAKIFY(var)  __weak typeof(var) weak_##var = var;

///*处理分割线没在最左边问题：ios8以后才有的问题*/\
#define AddTableViewLineAdjust \
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

/** block */
#define MKBlockExec(block, ...) if (block) { block(__VA_ARGS__); };
typedef void (^MKBlock)(id result);
typedef void (^MKBoolBlock)(BOOL bRet);
typedef void (^MKVoidBlock)(void);
typedef void (^MKIntegerBlock)(NSInteger index);

#pragma mark - ***** 枚举 *****
/** tableView 上下拉 刷新 */
typedef enum {
    MKTableViewRefreshTypeNone      = 0,            /*!< 不添加刷新 */
    MKTableViewRefreshTypeHeader    = 1 << 1,       /*!< 头部 */
    MKTableViewRefreshTypeFooter    = 1 << 2,       /*!< 尾部 */
    MKTableViewRefreshTypeAll       = ~0UL
}MKTableViewRefreshType;

#define MKActionSheetDefine
