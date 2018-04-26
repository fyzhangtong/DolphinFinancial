//
//  MessageCenterTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MessageCenterTableViewCell.h"

#import "DFNotice.h"

@interface MessageCenterTableViewCell()

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *rightArrowImageView;

@end

@implementation MessageCenterTableViewCell

+ (CGFloat)cellHeight
{
    return 60.f;
}

- (void)makeView
{
    
    [self.contentView addSubview:self.tagLabel];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(13);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(16);
        make.width.mas_equalTo(34);
        make.height.mas_equalTo(22);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tagLabel.mas_right).mas_offset(15);
        make.top.mas_equalTo(_tagLabel.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-80);
    }];
    
    [self.contentView addSubview:self.dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(_titleLabel.mas_right);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentView addSubview:self.rightArrowImageView];
    [self.rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-8);
        make.width.height.mas_equalTo(24);
    }];
}

#pragma mark - getter

- (UILabel *)tagLabel
{
    if (!_tagLabel) {
        _tagLabel = [UILabel new];
        _tagLabel.textColor = DFColorWithHexString(@"#101010");
        _tagLabel.font = [UIFont systemFontOfSize:10];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.layer.cornerRadius = 4;
        _tagLabel.layer.borderWidth = 1;
        _tagLabel.layer.borderColor = DFColorWithHexString(@"#BBBBBB").CGColor;
        _tagLabel.text = @"公告";
    }
    return _tagLabel;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textColor = DFColorWithHexString(@"#969696");
        _dateLabel.font = [UIFont systemFontOfSize:10];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _dateLabel;
}

- (UIImageView *)rightArrowImageView
{
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    }
    return _rightArrowImageView;
}

- (void)reloadData:(DFNotice *)notice
{
    self.titleLabel.text = notice.title;
    self.dateLabel.text = notice.publish_time;
}

@end
