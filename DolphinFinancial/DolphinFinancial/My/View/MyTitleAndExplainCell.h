//
//  MyTitleAndExplainCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/20.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTitleAndExplainCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (void)registerCellTableView:(UITableView *)tableView;
+ (CGFloat)cellHeight;

- (void)reloadWithIcon:(NSString *)icon Title:(NSString *)title Explain:(NSString *)explain;

@end
