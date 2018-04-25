//
//  WithdrawaisMemberLevelTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/24.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "WithdrawaisMemberLevelTableViewCell.h"

@interface WithdrawaisMemberLevelTableViewCell()

@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *earnLabel;

@end

@implementation WithdrawaisMemberLevelTableViewCell

+ (CGFloat)cellHeight
{
    return 52;
}

- (void)makeView
{
    [self.contentView addSubview:self.levelLabel];
    [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(13);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentView addSubview:self.earnLabel];
    [_earnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_levelLabel.mas_left);
        make.top.mas_equalTo(_levelLabel.mas_bottom);
        make.height.mas_equalTo(23);
    }];
}

- (UILabel *)levelLabel
{
    if (!_levelLabel) {
        _levelLabel = [UILabel new];
        _levelLabel.textColor = DFColorWithHexString(@"#969696");
        _levelLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _levelLabel;
}
- (UILabel *)earnLabel
{
    if (!_earnLabel) {
        _earnLabel = [UILabel new];
        _earnLabel.textColor = DFColorWithHexString(@"#969696");
        _earnLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _earnLabel;
}
- (void)reloadMemberLevel:(NSString *)level earn:(NSString *)earn
{
    if (earn.length == 0) {
        return;
    }
    self.levelLabel.text = [NSString stringWithFormat:@"会员等级：%@",level];
    NSString *string1 = @"会员收益系数：";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",string1,earn]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:DFTINTCOLOR range:NSMakeRange(string1.length, earn.length)];
    self.earnLabel.attributedText = attributedString;
}
@end
