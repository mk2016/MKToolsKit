//
//  MKBaseTableViewCell.h
//  Taoqicar
//
//  Created by xmk on 16/10/8.
//  Copyright © 2016年 taoqicar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKBaseTableViewCell : UITableViewCell

+ (instancetype)cellWithDefaultStyle;
+ (instancetype)cellWithStyle:(UITableViewCellStyle)style;
+ (instancetype)cellWithDefaultStyleAndReuseIdentifier:(NSString *)reuseIdentifier;
/** init UI */
- (void)setupUI;

- (void)refreshUIWithModel:(id)model;

@end
