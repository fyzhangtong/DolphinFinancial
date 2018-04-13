//
//  FinancialTransferInfoTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/12.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinancialTransferInfoTableViewCell.h"

@interface FinancialTransferInfoTableViewCell()

@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) UILabel *infoLabel;


@end

@implementation FinancialTransferInfoTableViewCell

+ (CGFloat)cellHeight
{
    return 80;
}

- (void)makeView
{
    [self.contentView addSubview:self.amountLabel];
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(5);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
    }];
    
    [self.contentView addSubview:self.rateLabel];
    [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_amountLabel.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(_amountLabel.mas_left);
    }];
    
    [self.contentView addSubview:self.infoLabel];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_rateLabel.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(_rateLabel.mas_left);
    }];
}

- (UILabel *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [UILabel new];
        _amountLabel.textColor = DFColorWithHexString(@"#969696");
        _amountLabel.font = [UIFont systemFontOfSize:12];
        _amountLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _amountLabel;
}

- (UILabel *)rateLabel
{
    if (!_rateLabel) {
        _rateLabel = [UILabel new];
        _rateLabel.textColor = DFColorWithHexString(@"#969696");
        _rateLabel.font = [UIFont systemFontOfSize:12];
        _rateLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _rateLabel;
}

- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [UILabel new];
        _infoLabel.textColor = DFColorWithHexString(@"#969696");
        _infoLabel.font = [UIFont systemFontOfSize:12];
        _infoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _infoLabel;
}

- (void)reloadinterestRate:(NSString *)interestRate targetIncome:(NSString *)targetIncome incomeDescription:(NSString *)incomeDescription
{
    NSString *string1 = @"目标总收益：";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",string1,targetIncome]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:DFTINTCOLOR range:NSMakeRange(string1.length, targetIncome.length)];
    self.amountLabel.attributedText = attributedString;
    self.rateLabel.text = [NSString stringWithFormat:@"目标收益率：%@",interestRate];
    self.infoLabel.text = incomeDescription;
    
}

@end
