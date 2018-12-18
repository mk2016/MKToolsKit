//
//  UILabel+MKAdd.m
//  MKToolsKit
//
//  Created by xiaomk on 16/5/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "UILabel+MKAdd.h"

@implementation UILabel(MKAdd)

- (CGSize)mk_contentSizeWithWidth:(CGFloat)width{
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                             options:NSStringDrawingUsesLineFragmentOrigin
//                                                    | NSStringDrawingTruncatesLastVisibleLine
//                                                    | NSStringDrawingUsesFontLeading
                                          attributes:@{NSFontAttributeName: self.font}
                                             context:nil].size;
    
    return size;
}
@end
