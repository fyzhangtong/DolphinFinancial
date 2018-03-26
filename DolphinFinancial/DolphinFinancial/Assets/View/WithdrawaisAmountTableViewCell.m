//
//  WithdrawaisAmountTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "WithdrawaisAmountTableViewCell.h"

@interface WithdrawaisAmountTableViewCell()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *amountTextField;
@property (nonatomic, strong) UILabel *availableAmountLabel;

@end

@implementation WithdrawaisAmountTableViewCell

+ (CGFloat)cellHeight
{
    return 56.f;
}

- (void)makeView
{
    [self.contentView addSubview:self.amountTextField];
    [self.amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(13);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(15);
        make.height.mas_equalTo(40);
    }];
    
    [self.contentView addSubview:self.availableAmountLabel];
    [self.availableAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountTextField.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(23);
    }];
}
#pragma mark - getter
- (UITextField *)amountTextField
{
    if (!_amountTextField) {
        _amountTextField = [UITextField new];
        _amountTextField.textColor = DFColorWithHexString(@"#101010");
        _amountTextField.font = [UIFont systemFontOfSize:14.0];
        _amountTextField.placeholder = @"请输入提现金额";
        _amountTextField.delegate = self;
        
        UILabel *label = [UILabel new];
        label.textColor = DFColorWithHexString(@"#101010");
        label.font = [UIFont systemFontOfSize:14.0];
        label.text = @"提现金额     ";
        [label sizeToFit];
        
        _amountTextField.leftView = label;
        _amountTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _amountTextField;
}
- (UILabel *)availableAmountLabel
{
    if (!_availableAmountLabel) {
        _availableAmountLabel = [UILabel new];
        _availableAmountLabel.textColor = DFColorWithHexString(@"#101010");
        _availableAmountLabel.font = [UIFont systemFontOfSize:10.0];
        
        NSString *string1 = @"手续费：";
        CGFloat amount = 0;
        NSString *string2 = [NSString stringWithFormat:@"¥%.2f",amount];
        NSMutableAttributedString *attributeString =[[NSMutableAttributedString alloc]initWithString: [string1 stringByAppendingString:string2]];
        [attributeString addAttribute:NSForegroundColorAttributeName value:DFColorWithHexString(@"#101010") range:NSMakeRange(0, string1.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:DFTINTCOLOR range:NSMakeRange(string1.length, string2.length)];
        _availableAmountLabel.attributedText = attributeString;        
    }
    return _availableAmountLabel;
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

@end
