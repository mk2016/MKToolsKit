//
//  MKFileHelper.h
//  MKToolsKit
//
//  Created by xmk on 16/10/14.
//  Copyright © 2016年 mk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKFileHelper : NSObject


#pragma mark - ***** 读写 文件 *****
/** 读写文件 */
+ (BOOL)writeString:(NSString *)string toPath:(NSString *)path;
+ (NSString *)readStringOnPath:(NSString *)path;

/** 归档 解档文件*/
+ (BOOL)saveByKeyedArchiverWithData:(id)data filePath:(NSString *)filePath;
+ (id)getByKeyedUnarchiverWithFilePath:(NSString *)filePath;
+ (id)getByKeyedUnarchiverWithFilePath:(NSString *)filePath andClass:(Class)clazz;

#pragma mark - ***** 文件 缓存 处理 *****
+ (void)clearPath:(NSString *)path;
+ (float)folderSizeAtPath:(NSString *)path;
+ (float)fileSizeAtPath:(NSString *)path;

#pragma mark - ***** base *****
/** 文件属性 */
+ (NSDictionary *)fileAttriutesWithFilePath:(NSString*)path;
/** App 路径 */
+ (NSString *)homePath;
/** 获取Documents目录 */
+ (NSString *)documentPath;
/** 获取Cache目录 */
+ (NSString *)cachePath;
/** 获取Tmp目录 */
+ (NSString *)tmpPath;
/** 判断是否是为目录 */
+ (BOOL)isDir:(NSString *)path;
/** 文件是否存在 */
+ (BOOL)fileExistsAtPath:(NSString *)path;
/** 创建文件夹 */
+ (BOOL)createDir:(NSString *)dir;
/** 创建文件 */
+ (BOOL)createFilePath:(NSString *)file;
/** 删除文件 */
+ (BOOL)deleteFileWithPath:(NSString *)path;
/** 移动文件 */
+ (BOOL)moveItemAtPath:(NSString *)path1 toPath:(NSString *)path2;
@end
