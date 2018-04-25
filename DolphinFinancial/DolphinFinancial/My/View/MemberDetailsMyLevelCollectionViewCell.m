//
//  MemberDetailsMyLevelCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MemberDetailsMyLevelCollectionViewCell.h"

@interface MemberDetailsMyLevelCollectionViewCell()

@property (nonatomic, strong) UILabel *currentLevelLabel;
@property (nonatomic, strong) UILabel *nextLevelLabel;


@end

@implementation MemberDetailsMyLevelCollectionViewCell

+(CGSize)cellSize
{
    return CGSizeMake(DFSCREENW, 55);
}

- (void)makeView
{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.currentLevelLabel];
    [_currentLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(9);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
        make.height.mas_equalTo(23);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-40);
    }];
    
    [self.contentView addSubview:self.nextLevelLabel];
    [self.nextLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_currentLevelLabel.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(_currentLevelLabel.mas_right);
        make.height.mas_equalTo(23);
    }];
    
}

#pragma mark - getter

- (UILabel *)currentLevelLabel
{
    if (!_currentLevelLabel) {
        _currentLevelLabel = [UILabel new];
        _currentLevelLabel.font = [UIFont systemFontOfSize:14.0];
        
        
        
    }
    return _currentLevelLabel;
}


- (UILabel *)nextLevelLabel
{
    if (!_nextLevelLabel) {
        _nextLevelLabel = [UILabel new];
        _nextLevelLabel.textColor = [UIColor redColor];
        _nextLevelLabel.font = [UIFont systemFontOfSize:10.0];
        
    }
    return _nextLevelLabel;
}
- (void)reloadLevel:(NSString *)level needAmount:(NSString *)needAmount
{
    NSString *string1 = @"当前会员等级：";
    NSMutableAttributedString *attributeString =[[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"%@%@",string1,level]];
    [attributeString addAttribute:NSForegroundColorAttributeName value:DFColorWithHexString(@"#101010") range:NSMakeRange(0, string1.length)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:DFTINTCOLOR range:NSMakeRange(string1.length, level.length)];
    _currentLevelLabel.attributedText = attributeString;
    _nextLevelLabel.text = [NSString stringWithFormat:@"距离下一等级还需充值：%@",needAmount];
}


@end
