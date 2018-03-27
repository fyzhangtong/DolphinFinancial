//
//  MemberDetailsLevelExplainCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MemberDetailsLevelExplainCollectionViewCell.h"

@interface MemberDetailsLevelExplainCollectionViewCell()

@property (nonatomic, strong) UILabel *levelExplainLabel;


@end

@implementation MemberDetailsLevelExplainCollectionViewCell

+ (CGSize)cellSize
{
    return CGSizeMake(DFSCREENW, 55);
}


- (void)makeView
{
    [self.contentView addSubview:self.levelExplainLabel];
    [_levelExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(5);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-25);
    }];
    
}

#pragma mark - getter

- (UILabel *)levelExplainLabel
{
    if (!_levelExplainLabel) {
        _levelExplainLabel = [UILabel new];
        _levelExplainLabel.font = [UIFont systemFontOfSize:10.0];
        _levelExplainLabel.textColor = [UIColor redColor];
        _levelExplainLabel.numberOfLines = 0;
        _levelExplainLabel.text = @"说明：\n1.在线金额：指的是累计充值-累计提现\n2.余额收益奖励：奖励每日收益金额相应百分比数量的金额。";
    }
    return _levelExplainLabel;
}

@end
