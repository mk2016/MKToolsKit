//
//  MKFileHelper.m
//  MKToolsKit
//
//  Created by xmk on 16/10/14.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "MKFileHelper.h"

@implementation MKFileHelper

#pragma mark - ***** 读写 文件 *****
/** 写文件 */
+ (BOOL)writeString:(NSString *)string toPath:(NSString *)path{
    BOOL res = [string writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"文件写入成功");
    }else{
        NSLog(@"文件写入失败");
    }
    return res;
}

/** 读文件 */
+ (NSString *)readStringOnPath:(NSString *)path{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        return content;
    }
    NSLog(@"MKFileHelper : 获取失败");
    return nil;
}

/** 归档 到 文件*/
+ (BOOL)saveByKeyedArchiverWithData:(id)data filePath:(NSString *)filePath{
    BOOL bRet = [NSKeyedArchiver archiveRootObject:data toFile:filePath];
    if (bRet) {
        NSLog(@"MKFileHelper : 保存成功");
    }else{
        NSLog(@"MKFileHelper : 保存失败");
    }
    return bRet;
}

/** 解档 文件*/
+ (id)getByKeyedUnarchiverWithFilePath:(NSString *)filePath{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    return nil;
}

+ (id)getByKeyedUnarchiverWithFilePath:(NSString *)filePath andClass:(Class)clazz{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        if ([[NSKeyedUnarchiver unarchiveObjectWithFile:filePath] isKindOfClass:clazz]) {
            return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        }
    }
    return nil;
}

#pragma mark - ***** 文件 缓存 处理 *****
/** 清除缓存 */
+ (void)clearPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

/** 计算目录大小 */
+ (float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float folderSize = 0.0f;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            float fileSize = [self fileSizeAtPath:absolutePath];
            folderSize += fileSize;
        }
    }
    return folderSize;
}

/** 计算文件 缓存大小 */
+ (float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024/1024.0;
    }
    return 0;
}

#pragma mark - ***** base *****
/** 文件属性 */
+ (NSDictionary *)fileAttriutesWithFilePath:(NSString *)path{
    return [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
}

/** App 路径 */
+ (NSString *)homePath{
    return NSHomeDirectory();
}

/** 获取Documents目录 */
+ (NSString *)documentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

/** 获取Cache目录 */
+ (NSString *)cachePath{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

/** 获取Tmp目录 */
+ (NSString *)tmpPath{
    return NSTemporaryDirectory();
}

/** 判断是否是为目录 */
+ (BOOL)isDir:(NSString *)path{
    BOOL isDir;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && isDir){//目录
        return YES;
    }else{  // 不存在 || 不是目录
        return NO;
    }
}

/** 文件是否存在 */
+ (BOOL)fileIsExecutable:(NSString *)path{
    return [[NSFileManager defaultManager] isExecutableFileAtPath:path];
}

/** 创建文件夹 */
+ (void)createDir:(NSString *)dir{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![self isDir:dir]) {
        // 创建目录
        BOOL res = [fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
        if (res) {
            NSLog(@"文件夹创建成功 : %@" , dir);
        }else{
            NSLog(@"文件夹创建失败 : %@" , dir);
        }
    }else{
        NSLog(@"文件夹已存在");
    }
}

/** 创建文件 */
+ (BOOL)createFilePath:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功: %@" ,filePath);
    }else{
        NSLog(@"文件创建失败: %@" ,filePath);
    }
    return res;
}

/** 删除文件 */
+ (void)deleteFileWithPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager isExecutableFileAtPath:path]) {
        BOOL res = [fileManager removeItemAtPath:path error:nil];
        if (res) {
            NSLog(@"文件删除成功");
        }else{
            NSLog(@"文件删除失败");
        }
    }else{
        NSLog(@"文件不存在");
    }
}

@end
