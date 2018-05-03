//
//  HomeNoticeTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/5/3.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "HomeNoticeTableViewCell.h"

@interface HomeNoticeTableViewCell()

/**
 喇叭
 */
@property (nonatomic, strong) UIImageView *hornImageView;
/**
 公告标题
 */
@property (nonatomic, strong) UILabel *noticeTitleLabel;
/**
 查看
 */
@property (nonatomic, strong) UILabel *noticeCheckLabel;
/**
 右箭头
 */
@property (nonatomic, strong) UIImageView *noticeRightImageView;

@end

@implementation HomeNoticeTableViewCell

#pragma mark - getter
- (UIImageView *)hornImageView
{
    if (!_hornImageView) {
        _hornImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horn"]];
    }
    return _hornImageView;
}
- (UIImageView *)noticeRightImageView
{
    if (!_noticeRightImageView) {
        _noticeRightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    }
    return _noticeRightImageView;
}
- (UILabel *)noticeTitleLabel
{
    if (!_noticeTitleLabel) {
        _noticeTitleLabel = [UILabel new];
        _noticeTitleLabel.textAlignment = NSTextAlignmentLeft;
        _noticeTitleLabel.font = [UIFont systemFontOfSize:14];
        _noticeTitleLabel.textColor = DFColorWithHexString(@"#101010");
        _noticeTitleLabel.text = @"海豚理财V1.0.0正式发布公告";
    }
    return _noticeTitleLabel;
}
- (UILabel *)noticeCheckLabel
{
    if (!_noticeCheckLabel) {
        _noticeCheckLabel = [UILabel new];
        _noticeCheckLabel.textAlignment = NSTextAlignmentLeft;
        _noticeCheckLabel.font = [UIFont systemFontOfSize:12];
        _noticeCheckLabel.textColor = DFColorWithHexString(@"#b3b3b3");
        _noticeCheckLabel.text = @"查看";
    }
    return _noticeCheckLabel;
}

- (void)makeView
{
    [self.contentView addSubview:self.hornImageView];
    [self.hornImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.width.height.mas_equalTo(24);
    }];
    [self.contentView addSubview:self.noticeRightImageView];
    [self.noticeRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-8);
        make.width.height.mas_equalTo(22);
    }];
    [self.contentView addSubview:self.noticeCheckLabel];
    [self.noticeCheckLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noticeRightImageView.mas_centerY);
        make.right.mas_equalTo(self.noticeRightImageView.mas_left).mas_equalTo(-3);
        make.width.mas_equalTo(25);
    }];
    [self.contentView addSubview:self.noticeTitleLabel];
    [self.noticeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.hornImageView.mas_centerY);
        make.left.mas_equalTo(self.hornImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.noticeCheckLabel.mas_left).mas_offset(-10);
    }];
}

- (void)reloadNotice:(NSString *)notice
{
    self.noticeTitleLabel.text = notice;
}

@end
