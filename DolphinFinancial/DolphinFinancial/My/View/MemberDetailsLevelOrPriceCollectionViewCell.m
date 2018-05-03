//
//  MemberDetailsLevelOrPriceCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MemberDetailsLevelOrPriceCollectionViewCell.h"

@interface MemberDetailsLevelOrPriceCollectionViewCell()

@property (nonatomic, strong) UILabel *levelOrPriceLabel;


@end

@implementation MemberDetailsLevelOrPriceCollectionViewCell

+ (CGSize)cellSize
{
    return CGSizeMake((DFSCREENW-2)/2, 35);
}


- (void)makeView
{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.levelOrPriceLabel];
    [_levelOrPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
    
}

#pragma mark - getter

- (UILabel *)levelOrPriceLabel
{
    if (!_levelOrPriceLabel) {
        _levelOrPriceLabel = [UILabel new];
        _levelOrPriceLabel.font = [UIFont systemFontOfSize:14.0];
        _levelOrPriceLabel.textColor = DFColorWithHexString(@"#101010");
        _levelOrPriceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _levelOrPriceLabel;
}

- (void)reloadData:(NSString *)text color:(UIColor *)color
{
    _levelOrPriceLabel.text = text;
    _levelOrPriceLabel.textColor = color;
}

@end
