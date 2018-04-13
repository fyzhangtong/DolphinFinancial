//
//  FinancialTransferButtonTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/13.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol FinancialTransferButtonTableViewCellDelegate<NSObject>

@required
/**
 自动续存按钮点击事件

 @param sender 按钮
 */
- (void)autoTransferButtonAction:(UIButton *)sender;
/**
 确认转入按钮点击事件

 @param sender 按钮
 */
- (void)transferButtonAction:(UIButton *)sender;

@end

@interface FinancialTransferButtonTableViewCell : BaseTableViewCell

@property (nonatomic, weak) id<FinancialTransferButtonTableViewCellDelegate> delegate;

@end
