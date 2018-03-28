//
//  MyFinancialDetailsTotalTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyFinancialDetailsTotalTableViewCell.h"

@interface MyFinancialDetailsTotalTableViewCell()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *totalLabel;

@end

@implementation MyFinancialDetailsTotalTableViewCell

+(CGFloat)cellHeight
{
    return 100;
}


- (void)makeView
{
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(20);
    }];
    
    [self.contentView addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_nameLabel.mas_centerX);
        make.top.mas_equalTo(_nameLabel.mas_top).mas_offset(30);
    }];
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = DFColorWithHexString(@"#101010");
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"一月定存";
    }
    return _nameLabel;
}

- (UILabel *)totalLabel
{
    if (!_totalLabel) {
        _totalLabel = [UILabel new];
        _totalLabel.textColor = DFTINTCOLOR;
        _totalLabel.font = [UIFont systemFontOfSize:32];
        _totalLabel.textAlignment = NSTextAlignmentRight;
        _totalLabel.text = @"3028.00";
    }
    return _totalLabel;
}

@end
