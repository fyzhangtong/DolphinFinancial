//
//  AssetsRecordTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 资产记录/收益记录cell
 */
@interface AssetsRecordTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (void)registerCellTableView:(UITableView *)tableView;
+ (CGFloat)cellHeight;

@end
