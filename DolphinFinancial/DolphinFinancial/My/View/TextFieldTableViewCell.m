//
//  TextFieldTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@interface TextFieldTableViewCell()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) void(^handle)(NSString *text);

@end

@implementation TextFieldTableViewCell

+ (CGFloat)cellHeight
{
    return 40;
}

- (void)makeView
{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(87);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView).mas_offset(0);
    }];
}

#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"原登录密码";
    }
    return _titleLabel;
}
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.textColor = DFColorWithHexString(@"#101010");
        _textField.font = [UIFont systemFontOfSize:14.0];
        _textField.placeholder = @"请输入原登录密码";
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeASCIICapable;
    
        
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}
#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        if ([textField respondsToSelector:@selector(resignFirstResponder)]) {
            [textField resignFirstResponder];
        }
        
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.handle) {
        self.handle(textField.text);
    }
}

-(void)reloadWithTitle:(NSString *)title placeholder:(NSString *)placeholder  didEndEditingHandle:(void(^)(NSString *text))handle
{
    self.titleLabel.text = title;
    self.textField.placeholder = placeholder;
    self.handle = handle;
}

@end
