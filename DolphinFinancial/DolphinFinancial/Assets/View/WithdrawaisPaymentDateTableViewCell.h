//
//  WithdrawaisPaymentDateTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 到账时间
 */
@interface WithdrawaisPaymentDateTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (void)registerCellTableView:(UITableView *)tableView;
+ (CGFloat)cellHeight;



@end
