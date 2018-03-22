//
//  FinacialExplainCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinacialExplainCollectionViewCell.h"

@interface FinacialExplainCollectionViewCell()

@property (nonatomic, strong) UIView *point;
@property (nonatomic, strong) UILabel *explainLabel;

@end

@implementation FinacialExplainCollectionViewCell

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
    return CGSizeMake(DFSCREENW, 24);
}
+ (NSString*)reuseIdentifier
{
    return NSStringFromClass([self class]);
}
+ (void)registCell:(UICollectionView *) collectionView
{
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:[self reuseIdentifier]];
}

- (void)reloadExplain:(NSString *)explain
{
    self.explainLabel.text = explain;
}

- (void)makeView
{
    [self.contentView addSubview:self.point];
    [self.point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(10);
        make.width.height.mas_equalTo(8);
    }];
    
    [self.contentView addSubview:self.explainLabel];
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.point.mas_centerY);
        make.left.mas_equalTo(self.point.mas_left).mas_offset(15);
    }];
}

#pragma mark - getter
- (UIView *)point
{
    if (!_point) {
        _point = [UIView new];
        _point.backgroundColor = DFColorWithHexString(@"#101010");
        _point.layer.cornerRadius = 4;
        _point.layer.masksToBounds = YES;
    }
    return _point;
}
- (UILabel *)explainLabel
{
    if (!_explainLabel) {
        _explainLabel = [UILabel new];
        _explainLabel.textAlignment = NSTextAlignmentCenter;
        _explainLabel.font = [UIFont systemFontOfSize:12];
        _explainLabel.textColor = DFColorWithHexString(@"##101010");
        _explainLabel.text = @"￥1000起投";
    }
    return _explainLabel;
}

@end
