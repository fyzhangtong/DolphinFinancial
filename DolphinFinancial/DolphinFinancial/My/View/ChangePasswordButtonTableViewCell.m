//
//  ChangePasswordButtonTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "ChangePasswordButtonTableViewCell.h"
#import "UIImage+ImageWithColor.h"

@interface ChangePasswordButtonTableViewCell()

@property (nonatomic, strong) UIButton *confirmButton;

@end;


@implementation ChangePasswordButtonTableViewCell

+ (CGFloat)cellHeight
{
    return 60;
}

- (void)makeView
{
    self.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(14);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-14);
        make.height.mas_equalTo(40);
    }];
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
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
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmChangePassword)]) {
        [self.delegate confirmChangePassword];
    }
}

@end
