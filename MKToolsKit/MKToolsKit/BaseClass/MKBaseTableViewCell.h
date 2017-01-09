//
//  MKBaseTableViewCell.h
//  Taoqicar
//
//  Created by xmk on 16/10/8.
//  Copyright © 2016年 taoqicar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKBaseTableViewCell : UITableViewCell

+ (instancetype)cellWithDefaultStyleTableView:(UITableView *)tableView;
+ (instancetype)cellWithDefaultStyleAndReuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView;
+ (instancetype)cellWithStyle:(UITableViewCellStyle)style tableView:(UITableView *)tableView;

+ (instancetype)cellByNibWith:(UITableView *)tableView;

/** init UI */
- (void)setupUI;

- (void)refreshUIWithModel:(id)model;

/** get cell height */
+ (CGFloat)getCellHeight;
+ (CGFloat)getCellHeightWithModel:(id)model;
@end
