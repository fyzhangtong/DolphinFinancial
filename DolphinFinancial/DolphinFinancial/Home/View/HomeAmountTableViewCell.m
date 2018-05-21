//
//  HomeAmountTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/5/3.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "HomeAmountTableViewCell.h"

@interface HomeAmountTableViewCell()

/**
 理财金额
 */
@property (nonatomic, strong) UILabel *amountLabel;
/**
 理财金额描述
 */
@property (nonatomic, strong) UILabel *amountDescLabel;
/**
 分割线
 */
@property (nonatomic, strong) UIView *amountBorrowerLine;
/**
 借款人数量
 */
@property (nonatomic, strong) UILabel *borrowersLabel;
/**
 借款人数量描述
 */
@property (nonatomic, strong) UILabel *borrowersDescLabel;

@end

@implementation HomeAmountTableViewCell

+(CGFloat)cellHeight
{
    return 91.f;
}
- (void)makeView
{
    self.contentView.backgroundColor = DFTINTCOLOR;
    [self.contentView addSubview:self.amountLabel];
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(16);
        make.centerX.mas_equalTo(self.contentView.mas_centerX).multipliedBy(0.5);
    }];
    [self.contentView addSubview:self.amountDescLabel];
    [_amountDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountLabel.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.amountLabel.mas_centerX);
    }];
    [self.contentView addSubview:self.borrowersLabel];
    [_borrowersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountLabel.mas_top);
        make.centerX.mas_equalTo(self.contentView.mas_centerX).multipliedBy(1.5);
    }];
    [self.contentView addSubview:self.borrowersDescLabel];
    [_borrowersDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.borrowersLabel.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.borrowersLabel.mas_centerX);
    }];
    [self.contentView addSubview:self.amountBorrowerLine];
    [self.amountBorrowerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(3);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-6);
        make.width.mas_equalTo(1);
    }];
}
#pragma mark - getter
- (UIView *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [UILabel new];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.font = [UIFont boldSystemFontOfSize:20];
        _amountLabel.textColor = [UIColor whiteColor];
        
    }
    return _amountLabel;
}

- (UILabel *)amountDescLabel
{
    if (!_amountDescLabel) {
        _amountDescLabel = [UILabel new];
        _amountDescLabel.textAlignment = NSTextAlignmentCenter;
        _amountDescLabel.font = [UIFont systemFontOfSize:12];
        _amountDescLabel.textColor = [UIColor whiteColor];
        _amountDescLabel.text = @"人均累计理财金额";
        
    }
    return _amountDescLabel;
}

- (UILabel *)borrowersLabel
{
    if (!_borrowersLabel) {
        _borrowersLabel = [UILabel new];
        _borrowersLabel.textAlignment = NSTextAlignmentCenter;
        _borrowersLabel.font = [UIFont boldSystemFontOfSize:18];
        _borrowersLabel.textColor = [UIColor whiteColor];
        
    }
    return _borrowersLabel;
}

- (UILabel *)borrowersDescLabel
{
    if (!_borrowersDescLabel) {
        _borrowersDescLabel = [UILabel new];
        _borrowersDescLabel.textAlignment = NSTextAlignmentCenter;
        _borrowersDescLabel.font = [UIFont systemFontOfSize:12];
        _borrowersDescLabel.textColor = [UIColor whiteColor];
        _borrowersDescLabel.text = @"累计借款人数量";
        
    }
    return _borrowersDescLabel;
}

- (UIView *)amountBorrowerLine
{
    if (!_amountBorrowerLine) {
        _amountBorrowerLine = [UIView new];
        _amountBorrowerLine.backgroundColor = DFColor(177, 177, 177);
//        _amountBorrowerLine.hidden = YES;
    }
    return _amountBorrowerLine;
}
- (void)reloadAmount:(NSString *)amount borrowerNumber:(NSString *)borrowNumber
{
    self.amountLabel.text = amount;
    self.borrowersLabel.text = borrowNumber;
}

@end
