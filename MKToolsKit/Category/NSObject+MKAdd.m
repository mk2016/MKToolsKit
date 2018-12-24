//
//  NSObject+MKAdd.m
//  MKToolsKit
//
//  Created by xmk on 2016/11/8.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "NSObject+MKAdd.h"

@implementation NSObject (MKAdd)

- (id)mk_copySelfPerfect{
    if (self) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
    }else{
        return nil;
    }
}
@end
