//
//  HomeAmountTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/5/3.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface HomeAmountTableViewCell : BaseTableViewCell

- (void)reloadAmount:(NSString *)amount borrowerNumber:(NSString *)borrowNumber;

@end
