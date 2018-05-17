//
//  WithdrawaisAccountNumberTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WithdrawaisAccountNumberTableViewCellDelegat<NSObject>

@required

- (void)accountNumberTextDidEndEdit:(UITextField *)textField;

@end

/**
 收款账号
 */
@interface WithdrawaisAccountNumberTableViewCell : UITableViewCell

@property (nonatomic, weak) id<WithdrawaisAccountNumberTableViewCellDelegat> delegate;

+ (NSString *)reuseIdentifier;
+ (void)registerCellTableView:(UITableView *)tableView;
+ (CGFloat)cellHeight;

- (void)reloadTitle:(NSString *)title placeholder:(NSString *)placeholder text:(NSString *)text editAble:(BOOL)editAble;

@end
