//
//  MyFinancialBorrowersHeadTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/28.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyFinancialBorrowersHeadTableViewCell.h"

@interface MyFinancialBorrowersHeadTableViewCell()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *numberLabel;
@property(nonatomic, strong) UILabel *borrowerLabel;
@property(nonatomic, strong) UILabel *amountLabel;
@property(nonatomic, strong) UILabel *stateLabel;
@property(nonatomic, strong) UILabel *financialNameLabel;


@end

@implementation MyFinancialBorrowersHeadTableViewCell


+ (CGFloat)cellHeight
{
    return 100;
}

- (void)makeView
{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(23);
    }];
    
    
    [self.contentView addSubview:self.numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(_titleLabel.mas_centerX);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentView addSubview:self.borrowerLabel];
    [_borrowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(13);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-5);
    }];
    
    [self.contentView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-10);
        make.bottom.mas_equalTo(_borrowerLabel.mas_bottom);
    }];
    
    [self.contentView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(10);
        make.bottom.mas_equalTo(_borrowerLabel.mas_bottom);
    }];
    
    [self.contentView addSubview:self.financialNameLabel];
    [self.financialNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        make.bottom.mas_equalTo(_borrowerLabel.mas_bottom);
    }];
}

#pragma makr - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"借款人";
    }
    return _titleLabel;
}
- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [UILabel new];
        _numberLabel.textColor = DFTINTCOLOR;
        _numberLabel.font = [UIFont boldSystemFontOfSize:18];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.text = @"4";
    }
    return _numberLabel;
}
- (UILabel *)borrowerLabel
{
    if (!_borrowerLabel) {
        _borrowerLabel = [UILabel new];
        _borrowerLabel.textColor = DFColorWithHexString(@"#101010");
        _borrowerLabel.font = [UIFont systemFontOfSize:16];
        _borrowerLabel.textAlignment = NSTextAlignmentCenter;
        _borrowerLabel.text = @"借款人";
    }
    return _borrowerLabel;
}
- (UILabel *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [UILabel new];
        _amountLabel.textColor = DFColorWithHexString(@"#101010");
        _amountLabel.font = [UIFont systemFontOfSize:16];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.text = @"匹配借款";
    }
    return _amountLabel;
}
- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.textColor = DFColorWithHexString(@"#101010");
        _stateLabel.font = [UIFont systemFontOfSize:16];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.text = @"状态";
    }
    return _stateLabel;
}
- (UILabel *)financialNameLabel
{
    if (!_financialNameLabel) {
        _financialNameLabel = [UILabel new];
        _financialNameLabel.textColor = DFColorWithHexString(@"#101010");
        _financialNameLabel.font = [UIFont systemFontOfSize:16];
        _financialNameLabel.textAlignment = NSTextAlignmentCenter;
        _financialNameLabel.text = @"匹配投资";
    }
    return _financialNameLabel;
}

@end
