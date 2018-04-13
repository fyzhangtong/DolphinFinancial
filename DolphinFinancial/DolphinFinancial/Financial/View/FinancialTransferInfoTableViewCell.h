//
//  FinancialTransferInfoTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/12.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface FinancialTransferInfoTableViewCell : BaseTableViewCell

- (void)reloadinterestRate:(NSString *)interestRate targetIncome:(NSString *)targetIncome incomeDescription:(NSString *)incomeDescription;

@end
