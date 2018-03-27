//
//  MemberDetailsLevelExplainCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MemberDetailsLevelRuleCollectionViewCell.h"

@interface MemberDetailsLevelRuleCollectionViewCell()

@property (nonatomic, strong) UILabel *levelExplainLabel;


@end

@implementation MemberDetailsLevelRuleCollectionViewCell

+ (CGSize)cellSize
{
    return CGSizeMake(DFSCREENW, 35);
}


- (void)makeView
{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.levelExplainLabel];
    [_levelExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-40);
    }];
    
}

#pragma mark - getter

- (UILabel *)levelExplainLabel
{
    if (!_levelExplainLabel) {
        _levelExplainLabel = [UILabel new];
        _levelExplainLabel.font = [UIFont systemFontOfSize:14.0];
        _levelExplainLabel.textColor = DFColorWithHexString(@"#101010");
        _levelExplainLabel.text = @"会员等级制度";
    }
    return _levelExplainLabel;
}


@end
