//
//  FinancialTranferProductNameTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/10.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinancialTranferProductNameTableViewCell.h"

@interface FinancialTranferProductNameTableViewCell()

/**
 产品名称
 */
@property (nonatomic, strong) UILabel *nameLabel;
/**
 描述
 */
@property (nonatomic, strong) UILabel *explainLabel;

@end

@implementation FinancialTranferProductNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)makeView
{
    [self.contentView addSubview:self.nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
    }];
    
    [self.contentView addSubview:self.explainLabel];
    [_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
    }];
}
#pragma makr - getter
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = DFColorWithHexString(@"#101010");
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
- (UILabel *)explainLabel
{
    if (!_explainLabel) {
        _explainLabel = [UILabel new];
        _explainLabel.textColor = DFColorWithHexString(@"#969696");
        _explainLabel.font = [UIFont systemFontOfSize:14];
        _explainLabel.textAlignment = NSTextAlignmentRight;
    }
    return _explainLabel;
}
- (void)reloadName:(NSString *)name rate:(NSString *)rate
{
    self.nameLabel.text = name;
    self.explainLabel.text = rate;
}

@end
