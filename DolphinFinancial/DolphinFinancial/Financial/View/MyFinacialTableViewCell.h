//
//  MyFinacialTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/21.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserFinancial;

@interface MyFinacialTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (void)registerCellTableView:(UITableView *)tableView;
+ (CGFloat)cellHeight;

- (void)reloadData:(UserFinancial *)product;

@end
