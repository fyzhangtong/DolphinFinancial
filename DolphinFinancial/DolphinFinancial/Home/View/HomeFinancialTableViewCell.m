//
//  HomeFinancialTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/5/3.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "HomeFinancialTableViewCell.h"
#import "DFProduct.h"

@interface HomeFinancialTableViewCell()

/**
 @"1月定存"
 */
@property (nonatomic, strong) UILabel *recommendingLabel1;
/**
 @"到期自动转出"
 */
@property (nonatomic, strong) UILabel *recommendingLabel2;
/**
 @"5.8%"
 */
@property (nonatomic, strong) UILabel *recommendingLabel3;
/**
 @"今日还剩100份"
 */
@property (nonatomic, strong) UILabel *recommendingLabel4;

@end

@implementation HomeFinancialTableViewCell


+(CGFloat)cellHeight
{
    return 60.f;
}
#pragma mark - getter


- (UILabel *)recommendingLabel1
{
    if (!_recommendingLabel1) {
        _recommendingLabel1 = [UILabel new];
        _recommendingLabel1.textAlignment = NSTextAlignmentLeft;
        _recommendingLabel1.font = [UIFont systemFontOfSize:14];
        _recommendingLabel1.textColor = DFColorWithHexString(@"#101010");
        _recommendingLabel1.text = @"1月定存";
    }
    return _recommendingLabel1;
}
- (UILabel *)recommendingLabel2
{
    if (!_recommendingLabel2) {
        _recommendingLabel2 = [UILabel new];
        _recommendingLabel2.textAlignment = NSTextAlignmentLeft;
        _recommendingLabel2.font = [UIFont systemFontOfSize:16];
        _recommendingLabel2.textColor = DFColorWithHexString(@"#1779D4");
        _recommendingLabel2.text = @"5.8%";
    }
    return _recommendingLabel2;
}

- (UILabel *)recommendingLabel3
{
    if (!_recommendingLabel3) {
        _recommendingLabel3 = [UILabel new];
        _recommendingLabel3.textAlignment = NSTextAlignmentLeft;
        _recommendingLabel3.font = [UIFont systemFontOfSize:12];
        _recommendingLabel3.textColor = DFColorWithHexString(@"#969696");
        _recommendingLabel3.text = @"到期自动转出";
    }
    return _recommendingLabel3;
}
- (UILabel *)recommendingLabel4
{
    if (!_recommendingLabel4) {
        _recommendingLabel4 = [UILabel new];
        _recommendingLabel4.textAlignment = NSTextAlignmentLeft;
        _recommendingLabel4.font = [UIFont systemFontOfSize:12];
        _recommendingLabel4.textColor = DFColorWithHexString(@"#969696");
        _recommendingLabel4.text = @"今日还剩100份";
    }
    return _recommendingLabel4;
}


- (void)makeView
{
    [self.contentView addSubview:self.recommendingLabel1];
    [self.recommendingLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_equalTo(7);
        make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(16);
    }];
    [self.contentView addSubview:self.recommendingLabel2];
    [self.recommendingLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.recommendingLabel1.mas_bottom).mas_equalTo(7);
        make.left.mas_equalTo(self.recommendingLabel1.mas_left);
    }];
    [self.contentView addSubview:self.recommendingLabel3];
    [self.recommendingLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.recommendingLabel1.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-18);
    }];
    [self.contentView addSubview:self.recommendingLabel4];
    [self.recommendingLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.recommendingLabel2.mas_centerY);
        make.right.mas_equalTo(self.recommendingLabel3.mas_right);
    }];
}
- (void)reloadProduct:(DFProduct *)product
{
    self.recommendingLabel1.text = product.name;
    self.recommendingLabel2.text = product.descriptions.firstObject;
    self.recommendingLabel3.text = product.interest_rate;
    self.recommendingLabel4.text = [NSString stringWithFormat:@"今日还剩%@份",product.residue_number];

}

@end
