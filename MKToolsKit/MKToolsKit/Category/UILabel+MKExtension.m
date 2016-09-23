//
//  UILabel+MKExtension.m
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/5/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "UILabel+MKExtension.h"

@implementation UILabel(MKExtension)

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
