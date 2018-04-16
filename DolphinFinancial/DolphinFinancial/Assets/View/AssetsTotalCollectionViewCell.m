//
//  AssetsTotalCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AssetsTotalCollectionViewCell.h"

@interface AssetsTotalCollectionViewCell()

@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *totalMoneyLabel;
@property (nonatomic, strong) UILabel *incomeLabel;
@property (nonatomic, strong) UILabel *incomeMoneyLabel;

@end

@implementation AssetsTotalCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self makeView];
    }
    return self;
}

+ (CGSize)cellSize
{
    return CGSizeMake(DFSCREENW, 68);
}
+ (NSString*)reuseIdentifier
{
    return NSStringFromClass([self class]);
}
+ (void)registCell:(UICollectionView *) collectionView
{
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:[self reuseIdentifier]];
}

- (void)makeView
{
    [self.contentView addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(12);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(13);
    }];
    [self.contentView addSubview:self.totalMoneyLabel];
    [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-5);
        make.left.mas_equalTo(self.totalLabel.mas_left);
    }];
    [self.contentView addSubview:self.incomeLabel];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.totalLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
    }];
    [self.contentView addSubview:self.incomeMoneyLabel];
    [self.incomeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.totalMoneyLabel.mas_centerY);
        make.right.mas_equalTo(self.incomeLabel.mas_right);
    }];
}
- (UILabel *)totalLabel
{
    if (!_totalLabel) {
        _totalLabel = [UILabel new];
        _totalLabel.textColor = DFColorWithHexString(@"#101010");
        _totalLabel.font = [UIFont systemFontOfSize:14.0];
        _totalLabel.text = @"总资产";
    }
    return _totalLabel;
}
- (UILabel *)totalMoneyLabel
{
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [UILabel new];
        _totalMoneyLabel.textColor = DFColorWithHexString(@"#1779D4");
        _totalMoneyLabel.font = [UIFont systemFontOfSize:20.0];
    }
    return _totalMoneyLabel;
}
- (UILabel *)incomeLabel
{
    if (!_incomeLabel) {
        _incomeLabel = [UILabel new];
        _incomeLabel.textColor = DFColorWithHexString(@"#101010");
        _incomeLabel.font = [UIFont systemFontOfSize:14.0];
        _incomeLabel.text = @"昨日收益";
    }
    return _incomeLabel;
}
- (UILabel *)incomeMoneyLabel
{
    if (!_incomeMoneyLabel) {
        _incomeMoneyLabel = [UILabel new];
        _incomeMoneyLabel.textColor = DFColorWithHexString(@"#101010");
        _incomeMoneyLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _incomeMoneyLabel;
}
- (void)reloadTotalAsset:(NSString *)totalAsset yesterdayEarn:(NSString *)yesterdayEarn
{
    self.totalMoneyLabel.text = totalAsset;
    self.incomeMoneyLabel.text = yesterdayEarn;
}

@end
