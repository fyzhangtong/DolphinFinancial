//
//  WithdrawalsConfirmTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "WithdrawalsConfirmTableViewCell.h"
#import "UIImage+ImageWithColor.h"

@interface WithdrawalsConfirmTableViewCell()

@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *confirmButton;


@end

@implementation WithdrawalsConfirmTableViewCell

+(CGFloat)cellHeight
{
    return 64.f;
}
- (void)makeView
{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(0);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLabel.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(14);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-14);
        make.height.mas_equalTo(40);
    }];
}
#pragma mark - getter
- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.textColor = DFColorWithHexString(@"#969696");
        _descLabel.font = [UIFont systemFontOfSize:8.0];
    }
    return _descLabel;
}
- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_confirmButton setBackgroundImage:[UIImage createImageWithColor:DFTINTCOLOR] forState:UIControlStateNormal];
        [_confirmButton setTitleColor:DFColorWithHexString(@"#FFFFFF") forState:UIControlStateNormal];
        _confirmButton.layer.cornerRadius = 4;
        _confirmButton.layer.masksToBounds = YES;
        [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmButton;
}
- (void)confirmButtonClick:(UIButton *)sender
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmWithdrawals)]) {
        [self.delegate confirmWithdrawals];
    }
}

- (void)reloadButtonTitle:(NSString *)title desc:(NSString *)desc
{
    _descLabel.text = desc;
    [_confirmButton setTitle:title forState:UIControlStateNormal];
}

@end
