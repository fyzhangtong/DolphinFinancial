//
//  MyFinancailBorrowerTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/28.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyFinancialBorrowerTableViewCell.h"

#import "Borrower.h"

@interface MyFinancialBorrowerTableViewCell()

@property(nonatomic, strong) UILabel *borrowerLabel;
@property(nonatomic, strong) UILabel *amountLabel;
@property(nonatomic, strong) UILabel *stateLabel;
@property(nonatomic, strong) UILabel *financialNameLabel;
@property(nonatomic, strong) UILabel *dateLabel;

@end;

@implementation MyFinancialBorrowerTableViewCell

+ (CGFloat)cellHeight
{
    return 60.f;
}

- (void)makeView
{
    
    [self.contentView addSubview:self.borrowerLabel];
    [_borrowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(13);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
    }];
    
    [self.contentView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-10);
        make.centerY.mas_equalTo(_borrowerLabel.mas_centerY);
    }];
    
    [self.contentView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(10);
        make.centerY.mas_equalTo(_borrowerLabel.mas_centerY);
    }];
    
    [self.contentView addSubview:self.financialNameLabel];
    [self.financialNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(_borrowerLabel.mas_centerY);
    }];
    
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_financialNameLabel.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-5);
    }];
}

#pragma makr - getter
- (UILabel *)borrowerLabel
{
    if (!_borrowerLabel) {
        _borrowerLabel = [UILabel new];
        _borrowerLabel.textColor = DFColorWithHexString(@"#101010");
        _borrowerLabel.font = [UIFont systemFontOfSize:14];
        _borrowerLabel.textAlignment = NSTextAlignmentCenter;
        _borrowerLabel.text = @"133****2910";
    }
    return _borrowerLabel;
}
- (UILabel *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [UILabel new];
        _amountLabel.textColor = DFColorWithHexString(@"#101010");
        _amountLabel.font = [UIFont systemFontOfSize:14];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.text = @"¥3981.82";
    }
    return _amountLabel;
}
- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.textColor = DFColorWithHexString(@"#101010");
        _stateLabel.font = [UIFont systemFontOfSize:14];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.text = @"借款中";
    }
    return _stateLabel;
}
- (UILabel *)financialNameLabel
{
    if (!_financialNameLabel) {
        _financialNameLabel = [UILabel new];
        _financialNameLabel.textColor = DFColorWithHexString(@"#101010");
        _financialNameLabel.font = [UIFont systemFontOfSize:14];
        _financialNameLabel.textAlignment = NSTextAlignmentCenter;
        _financialNameLabel.text = @"一月定存";
    }
    return _financialNameLabel;
}
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textColor = DFColorWithHexString(@"#BBBBBB");
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.text = @"2018-03-23";
    }
    return _dateLabel;
}
- (void)reloadBorrower:(Borrower *)borrower
{
    self.borrowerLabel.text = borrower.borrower;
    self.amountLabel.text = borrower.borrow_amount;
    self.stateLabel.text = borrower.status;
    self.financialNameLabel.text = borrower.product_name;
    self.dateLabel.text = borrower.borrow_time;
}

@end
