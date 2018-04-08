//
//  MyFinacialTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/21.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyFinacialTableViewCell.h"
#import "UserFinancial.h"

@interface MyFinacialTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *yesterdayIncomeLabel;
@property (nonatomic, strong) UILabel *totalIncomeLabel;
@property (nonatomic, strong) UILabel *expiryTimeLabel;
@property (nonatomic, strong) UILabel *buyAmountLabel;

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
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_equalTo(7);
        make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(16);
    }];
    [self.contentView addSubview:self.yesterdayIncomeLabel];
    [self.yesterdayIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(7);
        make.left.mas_equalTo(self.nameLabel.mas_left);
    }];
    [self.contentView addSubview:self.totalIncomeLabel];
    [self.totalIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-18);
    }];
    [self.contentView addSubview:self.buyAmountLabel];
    [self.buyAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.right.mas_equalTo(self.totalIncomeLabel.mas_left).mas_offset(0);
    }];
    
    
    [self.contentView addSubview:self.expiryTimeLabel];
    [self.expiryTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.yesterdayIncomeLabel.mas_centerY);
        make.right.mas_equalTo(self.totalIncomeLabel.mas_right);
    }];
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel = [UILabel new];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = DFColorWithHexString(@"#101010");
//        _nameLabel.text = @"1月定存";
    }
    return _nameLabel;
}
- (UILabel *)yesterdayIncomeLabel
{
    if (!_yesterdayIncomeLabel) {
        _yesterdayIncomeLabel = [UILabel new];
        _yesterdayIncomeLabel.textAlignment = NSTextAlignmentLeft;
        _yesterdayIncomeLabel.font = [UIFont systemFontOfSize:12];
        _yesterdayIncomeLabel.textColor = DFColorWithHexString(@"#E51C23");
//        _yesterdayIncomeLabel.text = @"昨日收益：+5.62%";
    }
    return _yesterdayIncomeLabel;
}

- (UILabel *)totalIncomeLabel
{
    if (!_totalIncomeLabel) {
        _totalIncomeLabel = [UILabel new];
        _totalIncomeLabel.textAlignment = NSTextAlignmentLeft;
        _totalIncomeLabel.font = [UIFont systemFontOfSize:16];
        _totalIncomeLabel.textColor = DFColorWithHexString(@"#E51C23");
//        _totalIncomeLabel.text = @"(+38.12)";
    }
    return _totalIncomeLabel;
}
- (UILabel *)buyAmountLabel
{
    if (!_buyAmountLabel) {
        _buyAmountLabel = [UILabel new];
        _buyAmountLabel.textAlignment = NSTextAlignmentLeft;
        _buyAmountLabel.font = [UIFont systemFontOfSize:16];
        _buyAmountLabel.textColor = DFColorWithHexString(@"#1779D4");
//        _buyAmountLabel.text = @"￥1000.00";
    }
    return _buyAmountLabel;
}
- (UILabel *)expiryTimeLabel
{
    if (!_expiryTimeLabel) {
        _expiryTimeLabel = [UILabel new];
        _expiryTimeLabel.textAlignment = NSTextAlignmentLeft;
        _expiryTimeLabel.font = [UIFont systemFontOfSize:12];
        _expiryTimeLabel.textColor = DFColorWithHexString(@"#969696");
//        _expiryTimeLabel.text = @"到期时间：2018-08-01";
    }
    return _expiryTimeLabel;
}

- (void)reloadData:(UserFinancial *)product
{
    self.nameLabel.text = product.product_name;
    self.yesterdayIncomeLabel.text = [NSString stringWithFormat:@"(%@)",product.yesterday_income];
    self.totalIncomeLabel.text = product.total_income;
    self.expiryTimeLabel.text = [NSString stringWithFormat:@"到期时间：%@",product.expiration_time];
    self.buyAmountLabel.text = product.buy_amount;
}

@end
