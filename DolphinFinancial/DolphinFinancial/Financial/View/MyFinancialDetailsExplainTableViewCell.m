//
//  MyFinancialDetailsExplainTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyFinancialDetailsExplainTableViewCell.h"

@interface MyFinancialDetailsExplainTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *explainLabel;
@property (nonatomic, strong) UIImageView *rightArrow;
@property (nonatomic, strong) MASConstraint *rightArrowWidthConstraint;

@end

@implementation MyFinancialDetailsExplainTableViewCell

+(CGFloat)cellHeight
{
    return 40;
}

- (void)reloadData:(NSString *)title explain:(NSString *)explain
{
    _titleLabel.text = title;
    _explainLabel.text = explain;

}

- (void)showRightArrow:(BOOL)show
{
    CGFloat width = show ? 24 : 0;
    self.rightArrowWidthConstraint.offset(width);
}

- (void)makeView
{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
    }];
    
    
    
    [self.contentView addSubview:self.rightArrow];
    [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        self.rightArrowWidthConstraint = make.width.mas_equalTo(0);
        make.height.mas_equalTo(24);
    }];
    
    [self.contentView addSubview:self.explainLabel];
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.rightArrow.mas_centerY);
        make.right.mas_equalTo(self.rightArrow.mas_left).mas_offset(0);
    }];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)explainLabel
{
    if (!_explainLabel) {
        _explainLabel = [UILabel new];
        _explainLabel.textColor = DFColorWithHexString(@"#969696");
        _explainLabel.font = [UIFont systemFontOfSize:14];
        _explainLabel.textAlignment = NSTextAlignmentRight;
    }
    return _explainLabel;
}
- (UIImageView *)rightArrow
{
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    }
    return _rightArrow;
}

@end
