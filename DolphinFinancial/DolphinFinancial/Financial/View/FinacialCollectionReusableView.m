//
//  FinacialCollectionReusableView.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinacialCollectionReusableView.h"

@interface FinacialCollectionReusableView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *explainLabel;

@end

@implementation FinacialCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeView];
    }
    return self;
}

+ (CGSize)viewSize
{
    return CGSizeMake(DFSCREENW, 33);
}
+ (NSString*)reuseIdentifier
{
    return NSStringFromClass([self class]);
}
+ (void)registSectionHeader:(UICollectionView *) collectionView
{
    [collectionView registerClass:[self class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[self reuseIdentifier]];
}
- (void)reloadTitle:(NSString *)title explain:(NSString *)explain
{
    self.titleLabel.text = title;
    self.explainLabel.text = explain;
}


- (void)makeView
{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(10);
    }];
    [self addSubview:self.explainLabel];
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = DFColorWithHexString(@"#F8F8F8");
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}
#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
    }
    return _titleLabel;
}

- (UILabel *)explainLabel
{
    if (!_explainLabel) {
        _explainLabel = [UILabel new];
        _explainLabel.textAlignment = NSTextAlignmentCenter;
        _explainLabel.font = [UIFont systemFontOfSize:14];
        _explainLabel.textColor = DFColorWithHexString(@"#969696");
    }
    return _explainLabel;
}


@end
