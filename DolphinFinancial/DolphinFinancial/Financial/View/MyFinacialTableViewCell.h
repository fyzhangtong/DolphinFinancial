//
//  MyFinacialTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/21.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFinacialTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (void)registerCellTableView:(UITableView *)tableView;
+ (CGFloat)cellHeight;

@end
