//
//  NSDictionary+MKAdd.m
//  MKToolsKit
//
//  Created by xmk on 2016/11/21.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "NSDictionary+MKAdd.h"

@implementation NSDictionary (MKAdd)

+ (NSDictionary *)mk_dictionaryWithJsonString:(id)json{
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [self mk_dictionaryWithJsonData:jsonData];
}

+ (NSDictionary *)mk_dictionaryWithJsonData:(NSData *)data{
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"json解析失败:%@",error);
        return nil;
    }
    return dic;
}

+ (NSDictionary *)mk_dictionaryWithObject:(id)obj{
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }else if ([obj isKindOfClass:[NSString class]]){
        return [self mk_dictionaryWithJsonString:obj];
    }else if ([obj isKindOfClass:[NSData class]]){
        return [self mk_dictionaryWithJsonData:obj];
    }
    return nil;
}
@end
