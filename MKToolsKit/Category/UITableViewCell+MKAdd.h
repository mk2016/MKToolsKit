//
//  UITableViewCell+MKAdd.h
//  MKToolsKit
//
//  Created by xmk on 2017/3/4.
//  Copyright © 2017年 mk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (MKAdd)

+ (instancetype)mk_cellWithDefaultStyleTableView:(UITableView *)tableView;
+ (instancetype)mk_cellWithDefaultStyleAndReuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView;
+ (instancetype)mk_cellWithStyle:(UITableViewCellStyle)style tableView:(UITableView *)tableView;
+ (instancetype)mk_cellWithStyle:(UITableViewCellStyle)style resuseIdentifier:(NSString *)identifier tableView:(UITableView *)tableView;
+ (instancetype)mk_cellByNibWith:(UITableView *)tableView;

+ (CGFloat)mk_cellHeight;
+ (CGFloat)mk_cellHeightWithModel:(id)model;

- (void)mk_setupUI;
- (void)mk_refreshUIWithModel:(id)model;

@end
