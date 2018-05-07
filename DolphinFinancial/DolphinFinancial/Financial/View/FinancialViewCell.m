//
//  FinancialViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinancialViewCell.h"
#import "DFProduct.h"

@interface FinancialViewCell()

@property (nonatomic, strong) UILabel *nameLabel;
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
    [tableView registerClass:[self class] forCellReuseIdentifier:[self reuseIdentifier]];
}
- (void)makeView
{
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_equalTo(7);
        make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(16);
    }];
    [self.contentView addSubview:self.interestRateLabel];
    [self.interestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(7);
        make.left.mas_equalTo(self.nameLabel.mas_left);
    }];
    [self.contentView addSubview:self.explainLabel];
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-18);
    }];
    [self.contentView addSubview:self.surplusLabel];
    [self.surplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.interestRateLabel.mas_centerY);
        make.right.mas_equalTo(self.explainLabel.mas_right);
    }];
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = DFColorWithHexString(@"#101010");
    }
    return _nameLabel;
}
- (UILabel *)interestRateLabel
{
    if (!_interestRateLabel) {
        _interestRateLabel = [UILabel new];
        _interestRateLabel.textAlignment = NSTextAlignmentLeft;
        _interestRateLabel.font = [UIFont systemFontOfSize:16];
        _interestRateLabel.textColor = DFColorWithHexString(@"#1779D4");
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
    }
    return _surplusLabel;
}

- (void)reloadData:(DFProduct *)product
{
    self.nameLabel.text = product.name;
    self.interestRateLabel.text = product.interest_rate;
    
    NSString *explain = @"到期自动转出";
    NSString *surplus = @"";
    if (product.is_vip_product) {
        explain = [NSString stringWithFormat:@"vip%@以上购买",product.vip_level_limit];
        if (product.is_time_limit) {
            surplus = [NSString stringWithFormat:@"今日%@开售",product.purchase_time];
        }else if (product.is_quantity_limit){
            surplus = [NSString stringWithFormat:@"今日还剩%@份",product.residue_number];
        }
    }else if (product.is_time_limit){
        
        if (product.is_quantity_limit) {
            explain = [NSString stringWithFormat:@"今日%@开售",product.purchase_time];
            surplus = [NSString stringWithFormat:@"今日还剩%@份",product.residue_number];
        }else{
            surplus = [NSString stringWithFormat:@"今日%@开售",product.purchase_time];
        }
    }else if (product.is_quantity_limit){
        surplus = [NSString stringWithFormat:@"今日还剩%@份",product.residue_number];
    }
    
    self.explainLabel.text = explain;
    self.surplusLabel.text = surplus;
}

@end
