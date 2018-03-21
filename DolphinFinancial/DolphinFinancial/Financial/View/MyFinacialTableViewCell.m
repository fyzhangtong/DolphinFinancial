//
//  MyFinacialTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/21.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyFinacialTableViewCell.h"

@interface MyFinacialTableViewCell()
@property (nonatomic, strong) UILabel *nameLabell;
@property (nonatomic, strong) UILabel *incomeLabel;
@property (nonatomic, strong) UILabel *totalIncomeLabel;
@property (nonatomic, strong) UILabel *expiryTimeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation MyFinacialTableViewCell

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
    [tableView registerClass:[self class] forCellReuseIdentifier:[self reuseIdentifier]];
}
- (void)makeView
{
    [self.contentView addSubview:self.nameLabell];
    [self.nameLabell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_equalTo(7);
        make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(16);
    }];
    [self.contentView addSubview:self.incomeLabel];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabell.mas_bottom).mas_equalTo(7);
        make.left.mas_equalTo(self.nameLabell.mas_left);
    }];
    [self.contentView addSubview:self.totalIncomeLabel];
    [self.totalIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabell.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-18);
    }];
    [self.contentView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabell.mas_centerY);
        make.right.mas_equalTo(self.totalIncomeLabel.mas_left).mas_offset(0);
    }];
    
    
    [self.contentView addSubview:self.expiryTimeLabel];
    [self.expiryTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.incomeLabel.mas_centerY);
        make.right.mas_equalTo(self.totalIncomeLabel.mas_right);
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
- (UILabel *)incomeLabel
{
    if (!_incomeLabel) {
        _incomeLabel = [UILabel new];
        _incomeLabel.textAlignment = NSTextAlignmentLeft;
        _incomeLabel.font = [UIFont systemFontOfSize:12];
        _incomeLabel.textColor = DFColorWithHexString(@"#E51C23");
        _incomeLabel.text = @"昨日收益：+5.62%";
    }
    return _incomeLabel;
}

- (UILabel *)totalIncomeLabel
{
    if (!_totalIncomeLabel) {
        _totalIncomeLabel = [UILabel new];
        _totalIncomeLabel.textAlignment = NSTextAlignmentLeft;
        _totalIncomeLabel.font = [UIFont systemFontOfSize:16];
        _totalIncomeLabel.textColor = DFColorWithHexString(@"#E51C23");
        _totalIncomeLabel.text = @"(+38.12)";
    }
    return _totalIncomeLabel;
}
- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.font = [UIFont systemFontOfSize:16];
        _moneyLabel.textColor = DFColorWithHexString(@"#1779D4");
        _moneyLabel.text = @"￥1000.00";
    }
    return _moneyLabel;
}
- (UILabel *)expiryTimeLabel
{
    if (!_expiryTimeLabel) {
        _expiryTimeLabel = [UILabel new];
        _expiryTimeLabel.textAlignment = NSTextAlignmentLeft;
        _expiryTimeLabel.font = [UIFont systemFontOfSize:12];
        _expiryTimeLabel.textColor = DFColorWithHexString(@"#969696");
        _expiryTimeLabel.text = @"到期时间：2018-08-01";
    }
    return _expiryTimeLabel;
}

@end
