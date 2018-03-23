//
//  WithdrawaisAccountNumberTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "WithdrawaisAccountNumberTableViewCell.h"

@interface WithdrawaisAccountNumberTableViewCell()

@property (nonatomic, strong) UITextField *accountNumberTextField;

@end

@implementation WithdrawaisAccountNumberTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeView];
    }
    return self;
}

+ (NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}
+ (CGFloat)cellHeight
{
    return 40;
}

+ (void)registerCellTableView:(UITableView *)tableView{
    [tableView registerClass:[self class] forCellReuseIdentifier:[self reuseIdentifier]];
}

- (void)makeView
{
    [self.contentView addSubview:self.accountNumberTextField];
    [self.accountNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(13);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(15);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
}
#pragma mark - getter
- (UITextField *)accountNumberTextField
{
    if (!_accountNumberTextField) {
        _accountNumberTextField = [UITextField new];
        _accountNumberTextField.textColor = DFColorWithHexString(@"#101010");
        _accountNumberTextField.font = [UIFont systemFontOfSize:14.0];
        _accountNumberTextField.placeholder = @"请输入收款账号";
        
        UILabel *label = [UILabel new];
        label.textColor = DFColorWithHexString(@"#101010");
        label.font = [UIFont systemFontOfSize:14.0];
        label.text = @"收款账号     ";
        [label sizeToFit];
        
        _accountNumberTextField.leftView = label;
        _accountNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _accountNumberTextField;
}

@end
