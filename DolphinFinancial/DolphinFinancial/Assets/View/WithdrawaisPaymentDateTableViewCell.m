//
//  WithdrawaisPaymentDateTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "WithdrawaisPaymentDateTableViewCell.h"

@interface WithdrawaisPaymentDateTableViewCell()

@property (nonatomic, strong) UILabel *paymentDateLabel;        //@"到账时间"
@property (nonatomic, strong) UILabel *nameLabel;         //@"审核通过后到账"
@property (nonatomic, strong) UILabel *remainderLabel;       //剩余次数
@property (nonatomic, strong) UIButton *selectButton;           //选择按钮


@end

@implementation WithdrawaisPaymentDateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeView];
    }
    return self;
}

+ (NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}
+ (CGFloat)cellHeight
{
    return 95;
}

+ (void)registerCellTableView:(UITableView *)tableView{
    [tableView registerClass:[self class] forCellReuseIdentifier:[self reuseIdentifier]];
}

- (void)makeView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.paymentDateLabel];
    [self.paymentDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(4);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(13);
        make.height.mas_equalTo(23);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = DFColorWithHexString(@"#F8F8F8");
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.paymentDateLabel.mas_bottom).mas_offset(4);
        make.height.mas_equalTo(1);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).mas_offset(4);
        make.left.mas_equalTo(self.paymentDateLabel.mas_left);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentView addSubview:self.remainderLabel];
    [self.remainderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom);
        make.left.mas_equalTo(self.paymentDateLabel.mas_left);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentView addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_equalTo(-15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_equalTo(-22);
        make.width.height.mas_equalTo(20);
    }];
}

#pragma mark - getter
- (UILabel *)paymentDateLabel
{
    if (!_paymentDateLabel) {
        _paymentDateLabel = [UILabel new];
        _paymentDateLabel.textColor = DFColorWithHexString(@"#101010");
        _paymentDateLabel.font = [UIFont systemFontOfSize:14.0];
        _paymentDateLabel.text = @"到账时间";
    }
    return _paymentDateLabel;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = DFColorWithHexString(@"#101010");
        _nameLabel.font = [UIFont systemFontOfSize:14.0];
        _nameLabel.text = @"审核通过后到账";
    }
    return _nameLabel;
}
- (UILabel *)remainderLabel
{
    if (!_remainderLabel) {
        _remainderLabel = [UILabel new];
        _remainderLabel.textColor = DFColorWithHexString(@"#969696");
        _remainderLabel.font = [UIFont systemFontOfSize:10.0];
        _remainderLabel.text = @"预计3个工作日";
    }
    return _remainderLabel;
}
- (UIButton *)selectButton
{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"withdrawais_payment_date_selected"] forState:UIControlStateSelected];
        _selectButton.selected = YES;
    }
    return _selectButton;
}

@end
