//
//  WithdrawalsConfirmTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol WithdrawalsConfirmTableViewCellDelegate<NSObject>

@required
- (void)confirmWithdrawals;

@end

/**
 提现确认cell
 */
@interface WithdrawalsConfirmTableViewCell : BaseTableViewCell

@property (nonatomic, weak) id<WithdrawalsConfirmTableViewCellDelegate> delegate;

- (void)reloadButtonTitle:(NSString *)title desc:(NSString *)desc;

@end
