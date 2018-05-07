//
//  BalanceViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BalanceViewController.h"
#import "UIImage+ImageWithColor.h"
#import "WithdrawalsViewController.h"
#import "RechargeViewController.h"

@interface BalanceViewController ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIButton *withdrawalsButton;
@property (nonatomic, strong) UIButton *rechargeButton;

@end

@implementation BalanceViewController

+ (void)pushToController:(UIViewController *)controller
{
    BalanceViewController *bvc = [[BalanceViewController alloc] init];
    [controller.navigationController pushViewController:bvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
    [self requestData];
}

- (void)makeView
{
    [self setCenterTitle:@"余额"];
    [self addLeftBackButton];
    [self.view addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(135);
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView.mas_top).mas_offset(12);
        make.centerX.mas_equalTo(_backView.mas_centerX);
        make.height.mas_equalTo(23);
    }];
    [self.view addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(1);
        make.centerX.mas_equalTo(_titleLabel.mas_centerX);
        make.height.mas_equalTo(35);
    }];
    
    [self.view addSubview:self.withdrawalsButton];
    [self.withdrawalsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.backView.mas_bottom).mas_offset(-20);
        make.centerX.mas_equalTo(self.backView.mas_centerX).multipliedBy(0.5);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.rechargeButton];
    [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.withdrawalsButton.mas_bottom);
        make.centerX.mas_equalTo(self.backView.mas_centerX).multipliedBy(1.5);
        make.width.height.mas_equalTo(self.withdrawalsButton);
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

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.text = @"我的余额";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.textColor = DFColorWithHexString(@"#101010");
        _moneyLabel.font = [UIFont systemFontOfSize:24.0];
        _moneyLabel.text = @"￥0.00";
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}

- (UIButton *)withdrawalsButton
{
    if (!_withdrawalsButton) {
        _withdrawalsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_withdrawalsButton setTitle:@"提现" forState:UIControlStateNormal];
        [_withdrawalsButton setTitleColor:DFTINTCOLOR forState:UIControlStateNormal];
        [_withdrawalsButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        _withdrawalsButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _withdrawalsButton.layer.cornerRadius = 4.0;
        _withdrawalsButton.layer.masksToBounds = YES;
        _withdrawalsButton.layer.borderColor = DFTINTCOLOR.CGColor;
        _withdrawalsButton.layer.borderWidth = 1;
        [_withdrawalsButton addTarget:self action:@selector(withdrawalsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withdrawalsButton;
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
- (void)withdrawalsButtonClick:(UIButton *)sender
{
    [WithdrawalsViewController pushToController:self];
}
- (void)rechargeButtonClick:(UIButton *)sender
{
    [RechargeViewController pushToController:self];
}

- (void)requestData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GTNetWorking getWithUrl:DOLPHIN_API_BALANCE params:nil showLoginIfNeed:YES success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.moneyLabel.text = data[@"balance"];
            });
            
        }else{
            [MBProgressHUD showTextAddToView:self.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showTextAddToView:self.view Title:@"网络出错，请稍后再试！" andHideTime:2];
    }];
}







@end
