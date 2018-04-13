//
//  FinancialTransferAmountTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/10.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinancialTransferAmountTableViewCell.h"

@interface FinancialTransferAmountTableViewCell()<UITextFieldDelegate>

/**
 标题
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 金额
 */
@property (nonatomic, strong) UITextField *amountTextField;
/**
 余额
 */
@property (nonatomic, strong) UILabel *balanceLabel;

@end

@implementation FinancialTransferAmountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 80;
}

- (void)makeView
{
    [self.contentView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(8);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
    }];
    
    [self.contentView addSubview:self.amountTextField];
    [_amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = DFColor(242, 242, 242);
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_amountTextField.mas_bottom).mas_offset(5);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [self.contentView addSubview:self.balanceLabel];
    [_balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(_amountTextField.mas_left);
    }];
}

#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"转入金额";
    }
    return _titleLabel;
}
- (UITextField *)amountTextField
{
    if (!_amountTextField) {
        _amountTextField = [[UITextField alloc] init];
        _amountTextField.placeholder = @"1000起投";
        _amountTextField.font = [UIFont systemFontOfSize:14];
        _amountTextField.textColor = DFColorWithHexString(@"#101010");
        _amountTextField.keyboardType = UIKeyboardTypeNumberPad;
        _amountTextField.delegate = self;
        
        UILabel *leftLabel = [UILabel new];
        leftLabel.textColor = DFColorWithHexString(@"#101010");
        leftLabel.font = [UIFont systemFontOfSize:17];
        leftLabel.text = @"¥    ";
        [leftLabel sizeToFit];
        
        _amountTextField.leftView = leftLabel;
        _amountTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _amountTextField;
}
- (UILabel *)balanceLabel
{
    if (!_balanceLabel) {
        _balanceLabel = [UILabel new];
        _balanceLabel.textColor = DFColorWithHexString(@"#969696");
        _balanceLabel.font = [UIFont systemFontOfSize:12];
        _balanceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _balanceLabel;
}

- (void)reloadBlance:(NSString *)balance
{
    self.balanceLabel.text = [NSString stringWithFormat:@"余额：%@",balance];
}

#pragma mark - textFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textDidEndEdit:)]) {
        [self.delegate textDidEndEdit:self.amountTextField];
    }
}

@end
