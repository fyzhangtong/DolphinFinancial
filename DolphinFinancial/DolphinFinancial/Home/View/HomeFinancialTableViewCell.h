//
//  HomeFinancialTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/5/3.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"
@class DFProduct;

@interface HomeFinancialTableViewCell : BaseTableViewCell

- (void)reloadProduct:(DFProduct *)product;

@end
