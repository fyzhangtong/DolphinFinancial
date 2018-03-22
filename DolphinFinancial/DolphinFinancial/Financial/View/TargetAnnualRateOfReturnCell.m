//
//  TargetAnnualRateOfReturnCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "TargetAnnualRateOfReturnCell.h"

@interface TargetAnnualRateOfReturnCell()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *rateLabel;

@end

@implementation TargetAnnualRateOfReturnCell

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
    return CGSizeMake(DFSCREENW, 100);
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
    [self.contentView setBackgroundColor:DFTINTCOLOR];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(12);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    [self.contentView addSubview:self.rateLabel];
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(0);
        make.centerX.mas_equalTo(self.nameLabel.mas_centerX);
        make.height.mas_equalTo(46);
    }];
}
#pragma mark - getter
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = DFColorWithHexString(@"#FFFFFF");
        _nameLabel.text = @"目标年化收益率";
    }
    return _nameLabel;
}

- (UILabel *)rateLabel
{
    if (!_rateLabel) {
        _rateLabel = [UILabel new];
        _rateLabel.textAlignment = NSTextAlignmentCenter;
        _rateLabel.font = [UIFont systemFontOfSize:32];
        _rateLabel.textColor = DFColorWithHexString(@"#FFFFFF");
        _rateLabel.text = @"5.8%";
    }
    return _rateLabel;
}


@end
