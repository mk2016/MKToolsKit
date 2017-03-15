//
//  MKBaseTableViewCell.m
//  Taoqicar
//
//  Created by xmk on 16/10/8.
//  Copyright © 2016年 taoqicar. All rights reserved.
//

#import "MKBaseTableViewCell.h"
#import "MKConst.h"
#import "UITableViewCell+MKAdd.h"

@implementation MKBaseTableViewCell

+ (instancetype)cellWithDefaultStyleTableView:(UITableView *)tableView{
    return [self mk_cellWithDefaultStyleTableView:tableView];
}

+ (instancetype)cellWithDefaultStyleAndReuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView{
    return [self mk_cellWithDefaultStyleAndReuseIdentifier:reuseIdentifier tableView:tableView];
}

+ (instancetype)cellWithStyle:(UITableViewCellStyle)style tableView:(UITableView *)tableView{
    return [self mk_cellWithStyle:style tableView:tableView];
}

+ (instancetype)cellWithStyle:(UITableViewCellStyle)style resuseIdentifier:(NSString *)identifier tableView:(UITableView *)tableView{
    return [self mk_cellWithStyle:style resuseIdentifier:identifier tableView:tableView];
}

+ (instancetype)cellByNibWith:(UITableView *)tableView{
    return [self mk_cellByNibWith:tableView];
}

+ (CGFloat)getCellHeight{
    return [self mk_cellHeight];
}

+ (CGFloat)getCellHeightWithModel:(id)model{
    return [self mk_cellHeightWithModel:model];
}

- (void)setupUI{
    // implementation in sub class
}

- (void)refreshUIWithModel:(id)model{
    [self mk_refreshUIWithModel:model];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
