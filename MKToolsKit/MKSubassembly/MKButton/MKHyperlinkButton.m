//
//  MKHyperlinkButton.m
//  MKToolsKit
//
//  Created by xmk on 2017/7/17.
//  Copyright © 2017年 mk. All rights reserved.
//

#import "MKHyperlinkButton.h"

@implementation MKHyperlinkButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _lineColor = [UIColor blueColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _lineColor = [UIColor blueColor];
    }
    return self;
}

- (void)setColor:(UIColor *)color{
    _lineColor = [color copy];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGFloat descender = self.titleLabel.font.descender;
    if([_lineColor isKindOfClass:[UIColor class]]){
        CGContextSetStrokeColorWithColor(contextRef, _lineColor.CGColor);
    }
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender+1);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender+1);
    
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
