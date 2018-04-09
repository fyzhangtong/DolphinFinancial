//
//  MyFinancailBorrowerTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/28.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"
@class Borrower;

@interface MyFinancialBorrowerTableViewCell : BaseTableViewCell

- (void)reloadBorrower:(Borrower *)borrower;

@end
