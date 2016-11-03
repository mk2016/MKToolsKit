//
//  NSObject+MKAddProperty.m
//  MKToolsKit
//
//  Created by xiaomk on 16/5/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "NSObject+MKAddProperty.h"
#import <objc/runtime.h>

static const int property_key;
static const int tagObj_key;

@implementation NSObject(MKAddProperty)

- (void)bindPropertyWithKey:(NSString *)aKey value:(id)aValue{
    if (!aKey || !aKey.length || !aValue) {
        return;
    }
    NSMutableDictionary *dic = [self _allProperties];
    [dic setValue:aValue forKey:aKey];
}

- (id)propertyValueForKey:(NSString *)aKey{
    if (!aKey || !aKey.length) {
        return nil;
    }
    NSMutableDictionary *dic = [self _allProperties];
    return [dic valueForKey:aKey];
}

- (void)removePropertyWithKey:(NSString *)aKey{
    if (!aKey || !aKey.length) {
        return;
    }
    NSMutableDictionary *dic = [self _allProperties];
    [dic removeObjectForKey:aKey];
}

- (void)removeAllBindProperty{
    NSMutableDictionary *dic = [self _allProperties];
    [dic removeAllObjects];
}


- (NSMutableDictionary *)_allProperties{
    NSMutableDictionary *allPropertiesDic = objc_getAssociatedObject(self, &property_key);
    
    if (!allPropertiesDic) {
        allPropertiesDic = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &property_key, allPropertiesDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return allPropertiesDic;
}

- (id)tagObj{
    return objc_getAssociatedObject(self, &tagObj_key);
}


- (void)setTagObj:(id)aTagObj{
    if (!aTagObj) {
        return;
    }
    objc_setAssociatedObject(self, &tagObj_key, aTagObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
