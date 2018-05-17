//
//  WithdrawaisAccountNumberTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "WithdrawaisAccountNumberTableViewCell.h"

@interface WithdrawaisAccountNumberTableViewCell()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *accountNumberTextField;
@property (nonatomic, strong) UILabel *titleLabel;

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
        _accountNumberTextField.delegate = self;
        _accountNumberTextField.keyboardType = UIKeyboardTypeDefault;
        
        
        
        _accountNumberTextField.leftView = self.titleLabel;
        _accountNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _accountNumberTextField;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}
#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        if ([textField respondsToSelector:@selector(resignFirstResponder)]) {
            [textField resignFirstResponder];
        }
        
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(accountNumberTextDidEndEdit:)]) {
        [self.delegate accountNumberTextDidEndEdit:textField];
    }
}
- (void)reloadTitle:(NSString *)title placeholder:(NSString *)placeholder text:(NSString *)text editAble:(BOOL)editAble
{
    self.titleLabel.text = title;
    if (text.length) {
        self.accountNumberTextField.text = text;
    }
    self.accountNumberTextField.enabled = editAble;
    [_titleLabel sizeToFit];
    self.accountNumberTextField.placeholder = placeholder;
}
@end
