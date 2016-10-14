//
//  MKFileHelper.m
//  MKToolsKit
//
//  Created by xmk on 16/10/14.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "MKFileHelper.h"

@implementation MKFileHelper

#pragma mark - ***** NSKeyedUnarchiver 归档 *****

/** 归档 到 文件*/
+ (void)saveByKeyedUnarchiverWith:(id)data filePath:(NSString*)filePath{
    BOOL bRet = [NSKeyedArchiver archiveRootObject:data toFile:filePath];
    if (bRet) {
        NSLog(@"MKFileHelper : 保存成功");
    }else{
        NSLog(@"MKFileHelper : 保存失败");
    }
}

/** 从 文件 获取归档信息*/
+ (id)getByKeyedUnarchiverWithFilePath:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    return nil;
}


#pragma mark - 保存 字符 到 写入文件
+ (void)saveToFileWithString:(NSString *)str filePath:(NSString *)filePath{
    BOOL bRet = [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (bRet) {
        NSLog(@"MKFileHelper : 保存成功");
    }else{
        NSLog(@"MKFileHelper : 保存失败");
    }
}

+ (NSString*)getStringWithFilePath:(NSString *)filePath{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSString* content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        return content;
    }
    NSLog(@"MKFileHelper : 获取失败");
    return nil;
}

@end
