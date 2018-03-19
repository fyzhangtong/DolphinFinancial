//
//  FinancialViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinancialViewCell.h"

@interface FinancialViewCell()

@property (nonatomic, strong) UILabel *nameLabell;
@property (nonatomic, strong) UILabel *interestRateLabel;
@property (nonatomic, strong) UILabel *explainLabel;
@property (nonatomic, strong) UILabel *surplusLabel;

@end

@implementation FinancialViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}
+ (CGFloat)cellHeight
{
    return 60;
}

+ (void)registerCellTableView:(UITableView *)tableView{
    [tableView registerClass:[self class] forCellReuseIdentifier:[FinancialViewCell reuseIdentifier]];
}
- (void)makeView
{
    [self.contentView addSubview:self.nameLabell];
    [self.nameLabell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_equalTo(7);
        make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(16);
    }];
    [self.contentView addSubview:self.interestRateLabel];
    [self.interestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabell.mas_bottom).mas_equalTo(7);
        make.left.mas_equalTo(self.nameLabell.mas_left);
    }];
    [self.contentView addSubview:self.explainLabel];
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabell.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-18);
    }];
    [self.contentView addSubview:self.surplusLabel];
    [self.surplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.interestRateLabel.mas_centerY);
        make.right.mas_equalTo(self.explainLabel.mas_right);
    }];
}
- (UILabel *)nameLabell
{
    if (!_nameLabell) {
        _nameLabell = [UILabel new];
        _nameLabell = [UILabel new];
        _nameLabell.textAlignment = NSTextAlignmentLeft;
        _nameLabell.font = [UIFont systemFontOfSize:14];
        _nameLabell.textColor = DFColorWithHexString(@"#101010");
        _nameLabell.text = @"1月定存";
    }
    return _nameLabell;
}
- (UILabel *)interestRateLabel
{
    if (!_interestRateLabel) {
        _interestRateLabel = [UILabel new];
        _interestRateLabel.textAlignment = NSTextAlignmentLeft;
        _interestRateLabel.font = [UIFont systemFontOfSize:16];
        _interestRateLabel.textColor = DFColorWithHexString(@"#1779D4");
        _interestRateLabel.text = @"5.8%";
    }
    return _interestRateLabel;
}

- (UILabel *)explainLabel
{
    if (!_explainLabel) {
        _explainLabel = [UILabel new];
        _explainLabel.textAlignment = NSTextAlignmentLeft;
        _explainLabel.font = [UIFont systemFontOfSize:12];
        _explainLabel.textColor = DFColorWithHexString(@"#969696");
        _explainLabel.text = @"到期自动转出";
    }
    return _explainLabel;
}
- (UILabel *)surplusLabel
{
    if (!_surplusLabel) {
        _surplusLabel = [UILabel new];
        _surplusLabel.textAlignment = NSTextAlignmentLeft;
        _surplusLabel.font = [UIFont systemFontOfSize:12];
        _surplusLabel.textColor = DFColorWithHexString(@"#969696");
        _surplusLabel.text = @"今日还剩100份";
    }
    return _surplusLabel;
}
@end
