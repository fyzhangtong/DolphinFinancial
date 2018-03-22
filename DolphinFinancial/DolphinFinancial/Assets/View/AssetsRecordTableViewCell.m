//
//  AssetsRecordTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AssetsRecordTableViewCell.h"

@interface AssetsRecordTableViewCell()

@property (nonatomic, strong) UILabel *operationTypeLabel;
@property (nonatomic, strong) UILabel *operationStateLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation AssetsRecordTableViewCell

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
    [self.contentView addSubview:self.operationTypeLabel];
    [self.operationTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_equalTo(7);
        make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(16);
    }];
    [self.contentView addSubview:self.operationStateLabel];
    [self.operationStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.operationTypeLabel.mas_bottom).mas_equalTo(7);
        make.left.mas_equalTo(self.operationTypeLabel.mas_left);
    }];
    [self.contentView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.operationTypeLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-18);
    }];
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.operationStateLabel.mas_centerY);
        make.right.mas_equalTo(self.moneyLabel.mas_right);
    }];
}
- (UILabel *)operationTypeLabel
{
    if (!_operationTypeLabel) {
        _operationTypeLabel = [UILabel new];
        _operationTypeLabel.textAlignment = NSTextAlignmentLeft;
        _operationTypeLabel.font = [UIFont systemFontOfSize:14];
        _operationTypeLabel.textColor = DFColorWithHexString(@"#101010");
        _operationTypeLabel.text = @"充值";
    }
    return _operationTypeLabel;
}
- (UILabel *)operationStateLabel
{
    if (!_operationStateLabel) {
        _operationStateLabel = [UILabel new];
        _operationStateLabel.textAlignment = NSTextAlignmentLeft;
        _operationStateLabel.font = [UIFont systemFontOfSize:12];
        _operationStateLabel.textColor = DFColorWithHexString(@"#1779D4");
        _operationStateLabel.text = @"进行中";
    }
    return _operationStateLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textColor = DFTINTCOLOR;
        _moneyLabel.text = @"+3,000.00";
    }
    return _moneyLabel;
}
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = DFColorWithHexString(@"#969696");
        _dateLabel.text = @"交易时间：01-03 11:29:10";
    }
    return _dateLabel;
}

@end
