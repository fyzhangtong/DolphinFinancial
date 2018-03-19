//
//  AssetsCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AssetsMoneyCollectionViewCell.h"

@interface AssetsMoneyCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *checkLabel;

@end

@implementation AssetsMoneyCollectionViewCell

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
    return CGSizeMake((DFSCREENW-1)/2, 68);
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
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(12);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(13);
    }];
    [self.contentView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(1);
        make.left.mas_equalTo(self.titleLabel.mas_left);
    }];
    [self.contentView addSubview:self.checkLabel];
    [self.checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).mas_offset(2);
        make.left.mas_equalTo(self.titleLabel.mas_left);
    }];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.text = @"余额";
    }
    return _titleLabel;
}
- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.textColor = DFColorWithHexString(@"#1779D4");
        _moneyLabel.font = [UIFont systemFontOfSize:12.0];
        _moneyLabel.text = @"¥0.00";
    }
    return _moneyLabel;
}
- (UILabel *)checkLabel
{
    if (!_checkLabel) {
        _checkLabel = [UILabel new];
        _checkLabel.textColor = DFColorWithHexString(@"#E51C23");
        _checkLabel.font = [UIFont systemFontOfSize:8.0];
        _checkLabel.text = @"点击查看";
    }
    return _checkLabel;
}

@end
