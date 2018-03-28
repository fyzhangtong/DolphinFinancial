//
//  MyFinancialDetailsExplainTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyFinancialDetailsExplainTableViewCell : BaseTableViewCell

- (void)reloadData:(NSString *)title explain:(NSString *)explain;

- (void)showRightArrow:(BOOL)show;

@end
