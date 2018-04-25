//
//  FinancialTransferAmountTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/10.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol FinancialTransferAmountTableViewCellDelegate<NSObject>
@required

- (void)textDidEndEdit:(UITextField *)textField;

@end;

@interface FinancialTransferAmountTableViewCell : BaseTableViewCell

@property (nonatomic, weak) id<FinancialTransferAmountTableViewCellDelegate> delegate;

- (void)reloadBlance:(NSString *)balance fee:(NSString *)fee;

@end
