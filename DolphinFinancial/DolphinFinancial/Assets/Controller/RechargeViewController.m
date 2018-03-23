//
//  RechargeViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "RechargeViewController.h"
#import "UIImage+ImageWithColor.h"

@interface RechargeViewController ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *yanLabel;
@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UIButton *rechargeButton;

@end

@implementation RechargeViewController

+ (void)pushToController:(UIViewController *)controller
{
    RechargeViewController *bvc = [[RechargeViewController alloc] init];
    [controller.navigationController pushViewController:bvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"充值"];
    [self addLeftBackButton];
    [self.view addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(108);
    }];
    
    [self.backView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView.mas_top).mas_offset(5);
        make.left.mas_equalTo(self.backView.mas_left).mas_offset(13);
        make.height.mas_equalTo(23);
    }];
    
    [self.backView addSubview:self.yanLabel];
    [self.yanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).mas_offset(7);
        make.left.mas_equalTo(self.backView.mas_left).mas_offset(3);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(33);
    }];
    
    [self.backView addSubview:self.moneyTextField];
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.yanLabel.mas_centerY);
        make.left.mas_equalTo(self.yanLabel.mas_right);
        make.right.mas_equalTo(self.backView.mas_right).mas_offset(-25);
        make.height.mas_equalTo(self.yanLabel.mas_height);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = DFColorWithHexString(@"#F8F8F8");
    [self.backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yanLabel.mas_bottom);
        make.left.right.mas_equalTo(self.backView);
        make.height.mas_equalTo(1);
    }];
    
    [self.backView addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).mas_offset(3);
        make.left.mas_equalTo(self.backView.mas_left).mas_offset(13);
        make.height.mas_equalTo(23);
    }];
    
    [self.view addSubview:self.rechargeButton];
    [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView.mas_bottom).mas_offset(27);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(13);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-13);
        make.height.mas_equalTo(40);
    }];
}
#pragma mark - getter
- (UIView *)backView
{
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.textColor = DFColorWithHexString(@"#101010");
        _moneyLabel.font = [UIFont systemFontOfSize:14.0];
        _moneyLabel.text = @"充值金额";
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}
- (UILabel *)yanLabel
{
    if (!_yanLabel) {
        _yanLabel = [UILabel new];
        _yanLabel.textColor = DFColorWithHexString(@"#101010");
        _yanLabel.font = [UIFont systemFontOfSize:24.0];
        _yanLabel.text = @"￥";
        _yanLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _yanLabel;
}
- (UITextField *)moneyTextField
{
    if (!_moneyTextField) {
        _moneyTextField = [UITextField new];
        _moneyTextField.textColor = DFColorWithHexString(@"#101010");
        _moneyTextField.font = [UIFont systemFontOfSize:14.0];
        _moneyTextField.placeholder = @"请输入充值金额";
    }
    return _moneyTextField;
}
- (UILabel *)balanceLabel
{
    if (!_balanceLabel) {
        _balanceLabel = [UILabel new];
        _balanceLabel.textColor = DFColorWithHexString(@"#969696");
        _balanceLabel.font = [UIFont systemFontOfSize:12.0];
        _balanceLabel.text = @"余额：￥0.00";
        _balanceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _balanceLabel;
}

- (UIButton *)rechargeButton
{
    if (!_rechargeButton) {
        _rechargeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
        [_rechargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rechargeButton setBackgroundImage:[UIImage createImageWithColor:DFTINTCOLOR] forState:UIControlStateNormal];
        _rechargeButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _rechargeButton.layer.cornerRadius = 4.0;
        _rechargeButton.layer.masksToBounds = YES;
        [_rechargeButton addTarget:self action:@selector(rechargeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeButton;
}

#pragma mark - action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)rechargeButtonClick:(UIButton *)sender
{
    
}


@end
