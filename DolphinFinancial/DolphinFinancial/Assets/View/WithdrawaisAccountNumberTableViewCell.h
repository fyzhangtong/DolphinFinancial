//
//  WithdrawaisAccountNumberTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 收款账号
 */
@interface WithdrawaisAccountNumberTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (void)registerCellTableView:(UITableView *)tableView;
+ (CGFloat)cellHeight;

- (void)reloadTitle:(NSString *)title placeholder:(NSString *)placeholder;

@end
