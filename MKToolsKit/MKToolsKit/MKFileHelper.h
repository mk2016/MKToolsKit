//
//  MKFileHelper.h
//  MKToolsKit
//
//  Created by xmk on 16/10/14.
//  Copyright © 2016年 mk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKFileHelper : NSObject

#pragma mark - ***** NSKeyedUnarchiver 归档 *****

/** 归档 到 文件*/
+ (void)saveByKeyedUnarchiverWith:(id)data filePath:(NSString*)filePath;

/** 从 文件 获取归档信息*/
+ (id)getByKeyedUnarchiverWithFilePath:(NSString *)filePath;

@end
