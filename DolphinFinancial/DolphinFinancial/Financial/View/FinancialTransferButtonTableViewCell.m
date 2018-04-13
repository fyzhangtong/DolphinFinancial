//
//  FinancialTransferButtonTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/13.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinancialTransferButtonTableViewCell.h"
#import "UIImage+ImageWithColor.h"

@interface FinancialTransferButtonTableViewCell()

@property (nonatomic, strong) UIButton *autoTransferButton;
@property (nonatomic, strong) UIButton *transferButton;

@end

@implementation FinancialTransferButtonTableViewCell

+ (CGFloat)cellHeight
{
    return 60;
}

- (void)makeView
{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.autoTransferButton];
    [_autoTransferButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(8);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentView addSubview:self.transferButton];
    [_transferButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_autoTransferButton.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(14);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-14);
        make.height.mas_equalTo(40);
    }];
}

- (UIButton *)autoTransferButton
{
    if (!_autoTransferButton) {
        _autoTransferButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_autoTransferButton setTitle:@"到期后自动续投" forState:UIControlStateNormal];
        _autoTransferButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_autoTransferButton setTitleColor:DFColorWithHexString(@"#969696") forState:UIControlStateNormal];
        [_autoTransferButton setImage:[UIImage imageNamed:@"transfer_select"] forState:UIControlStateNormal];
        [_autoTransferButton setImage:[UIImage imageNamed:@"transfer_selected"] forState:UIControlStateSelected];
        [_autoTransferButton addTarget:self action:@selector(autoTransferButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _autoTransferButton;
}

- (UIButton *)transferButton
{
    if (!_transferButton) {
        _transferButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_transferButton setTitle:@"确认转入" forState:UIControlStateNormal];
        _transferButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_transferButton setBackgroundImage:[UIImage createImageWithColor:DFTINTCOLOR] forState:UIControlStateNormal];
        [_transferButton setTitleColor:DFColorWithHexString(@"#FFFFFF") forState:UIControlStateNormal];
        _transferButton.layer.cornerRadius = 4;
        _transferButton.layer.masksToBounds = YES;
        [_transferButton addTarget:self action:@selector(transferButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _transferButton;
}
- (void)autoTransferButtonClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(autoTransferButtonAction:)]) {
        [self.delegate autoTransferButtonAction:sender];
    }
}
- (void)transferButtonClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(transferButtonAction:)]) {
        [self.delegate transferButtonAction:sender];
    }
}
@end
