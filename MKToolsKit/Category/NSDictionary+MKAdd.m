//
//  NSDictionary+MKAdd.m
//  MKToolsKit
//
//  Created by xmk on 2016/11/21.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "NSDictionary+MKAdd.h"

@implementation NSDictionary (MKAdd)

+ (NSDictionary *)mk_dictionaryWithJson:(id)json{
    if (!json || json == (id)kCFNull) {
        return nil;
    }
    if ([json isKindOfClass:[NSDictionary class]]) {
        return json;
    }
    
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSString class]]){
        if (((NSString *)json).length == 0){
            return nil;
        }
        jsonData = [(NSString *)json dataUsingEncoding:NSUTF8StringEncoding];
    }else if ([json isKindOfClass:[NSData class]]){
        jsonData = json;
    }
    
    NSDictionary *dic = nil;
    if (jsonData){
        NSError *error;
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];   //NSJSONReadingMutableContainers
        if (error){
            dic = nil;
            NSLog(@"json parsing fail : %@",error);
        }
    }
    if (dic && [dic isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *tempDic = dic.mutableCopy;
        NSArray *valueAry = [tempDic allKeys];
        for (NSString *key in valueAry) {
            if ([[tempDic objectForKey:key] isEqual:[NSNull null]]){
                [tempDic setObject:@"" forKey:key];
            }
        }
        return tempDic.copy;
    }
    return nil;
}
@end
