//
//  MessageDetailsViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MessageDetailsViewController.h"

#import "DFNotice.h"

@interface MessageDetailsViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) DFNotice *notice;

@end

@implementation MessageDetailsViewController

+ (void)pushToController:(UINavigationController *)navigationController notice:(DFNotice *)notice
{
    if (notice == nil || navigationController == nil) {
        return;
    }
    MessageDetailsViewController *mdvc = [[MessageDetailsViewController alloc] init];
    mdvc.notice = notice;
    [navigationController pushViewController:mdvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCenterTitle:@"消息详情"];
    [self addLeftBackButton];
    [self makeView];
    self.titleLabel.text = self.notice.title;
    self.contentLabel.text = [NSString stringWithFormat:@"      %@",self.notice.content];
}

- (void)makeView
{
    [self.view addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    
    UIView * contentView = [[UIView alloc] init];
    contentView.backgroundColor = DFColorWithHexString(@"#F8F8F8");
    [self.scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    [contentView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.mas_top).mas_offset(40);
        make.left.mas_equalTo(contentView.mas_left).mas_offset(60);
        make.right.mas_equalTo(contentView.mas_right).mas_offset(-60);
    }];
    
    [contentView addSubview:self.contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(contentView.mas_left).mas_offset(20);
        make.right.mas_equalTo(contentView.mas_right).mas_offset(-20);
    }];
}
#pragma mark - getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = DFColorWithHexString(@"#101010");
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
