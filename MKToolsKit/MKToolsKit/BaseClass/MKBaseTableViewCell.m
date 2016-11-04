//
//  MKBaseTableViewCell.m
//  Taoqicar
//
//  Created by xmk on 16/10/8.
//  Copyright © 2016年 taoqicar. All rights reserved.
//

#import "MKBaseTableViewCell.h"

@implementation MKBaseTableViewCell

+ (instancetype)cellWithDefaultStyle{
    NSString *reuseIdentifier = NSStringFromClass([self class]);
//    ELog(@" reuseIdentifier : %@",reuseIdentifier);
    return [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

+ (instancetype)cellWithDefaultStyleAndReuseIdentifier:(NSString *)reuseIdentifier{
    return [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
//    self.frame = CGRectMake(0, 0, MKSCREEN_WIDTH, 44);    
//    UIView* tempView = [[UIView alloc] init];
//    [self setBackgroundView:tempView];
//    self.backgroundColor = [UIColor clearColor];
}

- (void)refreshUIWithModel:(id)model{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
