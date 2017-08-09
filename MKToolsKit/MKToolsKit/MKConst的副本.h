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
#   define DLOG(...) NSLog(@"[DLog] f:%s, l:%d, log:%@", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#   define ELOG(fmt, ...) NSLog((@"[Elog] " fmt), ##__VA_ARGS__);
#   define MK_DEBUG_STATUS YES
#else
#   define DLOG(...)
#   define ELOG(...)
#   define MK_DEBUG_STATUS NO
#endif


#define MK_DEVICE_SYS_VERSION_FLOAT_VALUE [[[UIDevice currentDevice] systemVersion] floatValue]

#define MK_IS_iPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define MK_IS_SIMULATOR (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)
#define MK_IS_Pad       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)




/** 系统单例 简写 */
#define MK_APPLICATION       [UIApplication sharedApplication]
#define MK_NOTIFICATION      [NSNotificationCenter defaultCenter]
#define MK_USER_DEFAULTS     [NSUserDefaults standardUserDefaults]
#define MK_FILE_MANAGER      [NSFileManager defaultManager]

/** 屏幕尺寸 */
#define MK_SCREEN_WIDTH      [UIScreen mainScreen].bounds.size.width
#define MK_SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define MK_SCREEN_SIZE       [UIScreen mainScreen].bounds.size
#define MK_SCREEN_BOUNDS     [UIScreen mainScreen].bounds

/** 颜色 */
#define MK_COLOR_RGB(r, g, b)        [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]
#define MK_COLOR_RGBA(r, g, b, a)    [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:(a)]
#define MK_COLOR_HEX(rgbValue)       [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f \
                                                    green:((float)((rgbValue & 0xFF00) >> 8))/255.0f \
                                                     blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0f]

/** 单例 */
#define MK_IMPL_SHARED_INSTANCE(type) + (instancetype)sharedInstance {\
                                            static type *sharedInstance = nil;\
                                            static dispatch_once_t once;\
                                            dispatch_once(&once, ^{\
                                                sharedInstance = [[self alloc] init];\
                                            });\
                                            return sharedInstance;}

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


/** 引用 */
#define MK_WEAKSELF          __weak typeof(self) weakSelf = self;
#define MK_WEAKIFY(var)      __weak typeof(var) weak_##var = var;
#define MK_STRONGSELF        __strong typeof(weakSelf) strongSelf = weakSelf;
#define MK_STRONGIFY(var)    __strong typeof(var) strong_##var = var;

/** block */
#define MK_BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };


typedef void (^MKBlock)(id result);
typedef void (^MKBoolBlock)(BOOL bRet);
typedef void (^MKVoidBlock)(void);
typedef void (^MKIntegerBlock)(NSInteger index);

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

#pragma mark - ***** 枚举 *****
/** tableView 上下拉 刷新 */
typedef enum {
    MKTableViewRefreshTypeNone      = 0,            /*!< 不添加刷新 */
    MKTableViewRefreshTypeHeader    = 1 << 1,       /*!< 头部 */
    MKTableViewRefreshTypeFooter    = 1 << 2,       /*!< 尾部 */
    MKTableViewRefreshTypeAll       = ~0UL
}MKTableViewRefreshType;

