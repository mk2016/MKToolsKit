//
//  UITableViewCell+MKAdd.m
//  MKToolsKit
//
//  Created by xmk on 2017/3/4.
//  Copyright © 2017年 mk. All rights reserved.
//

#import "UITableViewCell+MKAdd.h"
#import "MKConst.h"

@implementation UITableViewCell (MKAdd)


+ (instancetype)mk_cellWithDefaultStyleTableView:(UITableView *)tableView{
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    return [self mk_cellWithStyle:UITableViewCellStyleDefault resuseIdentifier:reuseIdentifier tableView:tableView];
}

+ (instancetype)mk_cellWithDefaultStyleAndReuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView{
    return [self mk_cellWithStyle:UITableViewCellStyleDefault resuseIdentifier:reuseIdentifier tableView:tableView];
}

+ (instancetype)mk_cellWithStyle:(UITableViewCellStyle)style tableView:(UITableView *)tableView{
    NSString *identifier = NSStringFromClass([self class]);
    return [self mk_cellWithStyle:style resuseIdentifier:identifier tableView:tableView];
}

+ (instancetype)mk_cellWithStyle:(UITableViewCellStyle)style resuseIdentifier:(NSString *)identifier tableView:(UITableView *)tableView{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:identifier];
        cell.selectedBackgroundView.backgroundColor = MKCOLOR_HEX(0xF0EFF0);
        [cell mk_setupUI];
    }
    return cell;
}

+ (instancetype)mk_cellByNibWith:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    Class class = NSClassFromString(className);
    UITableViewCell *cell;
    if (class) {
        cell = [tableView dequeueReusableCellWithIdentifier:className];
    }
    if (!cell) {
        UINib *_nib = [UINib nibWithNibName:className bundle:nil];
        if (_nib) {
            cell = [[_nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
            [cell mk_setupUI];
        }
    }
    return cell;
}

+ (CGFloat)mk_cellHeight{
    return 44;
}

+ (CGFloat)mk_cellHeightWithModel:(id)model{
    return 44;
}

- (void)mk_setupUI{
    if ([self respondsToSelector:@selector(setupUI)]) {
        [self performSelector:@selector(setupUI) withObject:nil];
    }
}

- (void)setupUI{}

- (void)mk_refreshUIWithModel:(id)model{}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self mk_setupUI];
}

@end
