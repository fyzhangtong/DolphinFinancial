//
//  SignUpViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/20.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "SignUpViewController.h"
#import "UIImage+ImageWithColor.h"
#import "SetPasswordController.h"
#import "RegistrationAgreementController.h"
#import "UserManager.h"

@interface SignUpViewController ()<UITextFieldDelegate>

@property (nonatomic, copy) void(^complete)(BOOL success);

@property (nonatomic, strong) UILabel *phoneNumberLabel;
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UILabel *verificationCodeLabel;
@property (nonatomic, strong) UITextField *verificationCodeTextField;
@property (nonatomic, strong) UIButton *verificationCodeButton;
@property (nonatomic, strong) UILabel *loginPasswordLabel;
@property (nonatomic, strong) UITextField *loginPasswordLabelTextField;
@property (nonatomic, strong) UILabel *refereeLabel;
@property (nonatomic, strong) UITextField *refereeTextField;

@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, strong) UILabel *aggreLabel;
@property (nonatomic, strong) UIButton *agreementButton;

@property (nonatomic, strong) UIButton *signUpButton;

@property (nonatomic, assign) BOOL isCountDowning;  //正在倒计时

@end

@implementation SignUpViewController

+ (void)pushToController:(UIViewController *)controller Complete:(void(^)(BOOL success))complete
{
    SignUpViewController *landVC = [[SignUpViewController alloc] init];
    landVC.complete = complete;
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller.navigationController pushViewController:landVC animated:YES];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)makeView
{
    [self setCenterTitle:@"会员注册"];
    [self addLeftBackButton];
    //手机号
    [self.view addSubview:self.phoneNumberLabel];
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
    }];
    
    [self.view addSubview:self.phoneNumberTextField];
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneNumberLabel.mas_centerY);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(80);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(12);
    }];
    UIView *line1 = [UIView new];
    line1.backgroundColor = DFColor(242, 242, 242);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumberLabel.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(11);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-11);
        make.height.mas_equalTo(1);
    }];
    //验证码
    [self.view addSubview:self.verificationCodeLabel];
    [self.verificationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.phoneNumberLabel.mas_left);
    }];
    [self.view addSubview:self.verificationCodeButton];
    [self.verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.verificationCodeLabel.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-12);
        make.width.mas_equalTo(124);
        make.height.mas_equalTo(40);
    }];
    [self.view addSubview:self.verificationCodeTextField];
    [self.verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.verificationCodeLabel.mas_centerY);
        make.left.mas_equalTo(self.phoneNumberTextField.mas_left);
        make.right.mas_equalTo(self.verificationCodeButton.mas_left).mas_offset(-11);
    }];
    UIView *line2 = [UIView new];
    line2.backgroundColor = DFColor(242, 242, 242);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verificationCodeLabel.mas_bottom).mas_offset(15);
        make.left.right.height.mas_equalTo(line1);
    }];
    //登录密码
    [self.view addSubview:self.loginPasswordLabel];
    [self.loginPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.phoneNumberLabel.mas_left);
    }];
    
    [self.view addSubview:self.loginPasswordLabelTextField];
    [self.loginPasswordLabelTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.loginPasswordLabel.mas_centerY);
        make.left.right.mas_equalTo(self.phoneNumberTextField);
    }];
    UIView *line3 = [UIView new];
    line3.backgroundColor = DFColor(242, 242, 242);
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginPasswordLabel.mas_bottom).mas_offset(15);
        make.left.right.height.mas_equalTo(line1);
    }];
    //推荐人
    [self.view addSubview:self.refereeLabel];
    [self.refereeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.phoneNumberLabel.mas_left);
    }];
    
    [self.view addSubview:self.refereeTextField];
    [self.refereeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.refereeLabel.mas_centerY);
        make.left.right.mas_equalTo(self.phoneNumberTextField);
    }];
    UIView *line4 = [UIView new];
    line4.backgroundColor = DFColor(242, 242, 242);
    [self.view addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.refereeLabel.mas_bottom).mas_offset(15);
        make.left.right.height.mas_equalTo(line1);
    }];
    
    [self.view addSubview:self.agreeButton];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line4.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(12);
        make.width.height.mas_equalTo(12);
    }];
    [self.view addSubview:self.aggreLabel];
    [self.aggreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.agreeButton.mas_centerY);
        make.left.mas_equalTo(self.agreeButton.mas_right).mas_offset(5);
    }];
    [self.view addSubview:self.agreementButton];
    [self.agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.agreeButton.mas_centerY);
        make.left.mas_equalTo(self.aggreLabel.mas_right).mas_offset(5);
    }];
    [self.view addSubview:self.signUpButton];
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.agreeButton.mas_bottom).mas_offset(10.0);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(12);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-12);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - getter
- (UILabel *)phoneNumberLabel
{
    if (!_phoneNumberLabel) {
        _phoneNumberLabel = [UILabel new];
        _phoneNumberLabel.textColor = DFColorWithHexString(@"#101010");
        _phoneNumberLabel.font = [UIFont systemFontOfSize:14];
        _phoneNumberLabel.textAlignment = NSTextAlignmentCenter;
        _phoneNumberLabel.text = @"手机号";
    }
    return _phoneNumberLabel;
}
- (UITextField *)phoneNumberTextField
{
    if (!_phoneNumberTextField) {
        _phoneNumberTextField = [UITextField new];
        _phoneNumberTextField.textColor = DFColorWithHexString(@"#101010");
        _phoneNumberTextField.font = [UIFont systemFontOfSize:14];
        _phoneNumberTextField.textAlignment = NSTextAlignmentLeft;
        _phoneNumberTextField.placeholder = @"请输入手机号";
        _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumberTextField.delegate = self;
        [_phoneNumberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneNumberTextField;
}
- (UILabel *)verificationCodeLabel
{
    if (!_verificationCodeLabel) {
        _verificationCodeLabel = [UILabel new];
        _verificationCodeLabel.textColor = DFColorWithHexString(@"#101010");
        _verificationCodeLabel.font = [UIFont systemFontOfSize:14];
        _verificationCodeLabel.textAlignment = NSTextAlignmentCenter;
        _verificationCodeLabel.text = @"验证码";
    }
    return _verificationCodeLabel;
}
- (UITextField *)verificationCodeTextField
{
    if (!_verificationCodeTextField) {
        _verificationCodeTextField = [UITextField new];
        _verificationCodeTextField.textColor = DFColorWithHexString(@"#101010");
        _verificationCodeTextField.font = [UIFont systemFontOfSize:14];
        _verificationCodeTextField.textAlignment = NSTextAlignmentLeft;
        _verificationCodeTextField.placeholder = @"请输入手机验证码";
        _verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _verificationCodeTextField.delegate = self;
        [_verificationCodeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _verificationCodeTextField;
}
- (UIButton *)verificationCodeButton
{
    if (!_verificationCodeButton) {
        _verificationCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verificationCodeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_verificationCodeButton setBackgroundImage:[UIImage createImageWithColor:DFTINTCOLOR] forState:UIControlStateNormal];
        [_verificationCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_verificationCodeButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
//        [_verificationCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _verificationCodeButton.layer.borderWidth = 1;
        _verificationCodeButton.layer.cornerRadius = 4;
        _verificationCodeButton.layer.masksToBounds = YES;
//        _verificationCodeButton.enabled = NO;
        _verificationCodeButton.layer.borderColor = DFTINTCOLOR.CGColor;
        [_verificationCodeButton addTarget:self action:@selector(getVerificationCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _verificationCodeButton;
}
- (UILabel *)loginPasswordLabel
{
    if (!_loginPasswordLabel) {
        _loginPasswordLabel = [UILabel new];
        _loginPasswordLabel.textColor = DFColorWithHexString(@"#101010");
        _loginPasswordLabel.font = [UIFont systemFontOfSize:14];
        _loginPasswordLabel.textAlignment = NSTextAlignmentCenter;
        _loginPasswordLabel.text = @"登录密码";
    }
    return _loginPasswordLabel;
}
- (UITextField *)loginPasswordLabelTextField
{
    if (!_loginPasswordLabelTextField) {
        _loginPasswordLabelTextField = [UITextField new];
        _loginPasswordLabelTextField.textColor = DFColorWithHexString(@"#101010");
        _loginPasswordLabelTextField.font = [UIFont systemFontOfSize:14];
        _loginPasswordLabelTextField.textAlignment = NSTextAlignmentLeft;
        _loginPasswordLabelTextField.placeholder = @"6-16位，含数字、字母";
        _loginPasswordLabelTextField.secureTextEntry = YES;
        _loginPasswordLabelTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _loginPasswordLabelTextField.delegate = self;
        [_loginPasswordLabelTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _loginPasswordLabelTextField;
}
- (UILabel *)refereeLabel
{
    if (!_refereeLabel) {
        _refereeLabel = [UILabel new];
        _refereeLabel.textColor = DFColorWithHexString(@"#101010");
        _refereeLabel.font = [UIFont systemFontOfSize:14];
        _refereeLabel.textAlignment = NSTextAlignmentCenter;
        _refereeLabel.text = @"推荐人";
    }
    return _refereeLabel;
}
- (UITextField *)refereeTextField
{
    if (!_refereeTextField) {
        _refereeTextField = [UITextField new];
        _refereeTextField.textColor = DFColorWithHexString(@"#101010");
        _refereeTextField.font = [UIFont systemFontOfSize:14];
        _refereeTextField.textAlignment = NSTextAlignmentLeft;
        _refereeTextField.placeholder = @"手机号(选填)";
        _refereeTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _refereeTextField.delegate = self;
        [_refereeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _refereeTextField;
}
- (UIButton *)agreeButton
{
    if (!_agreeButton) {
        _agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeButton setImage:[UIImage imageNamed:@"signup_select"] forState:UIControlStateNormal];
        [_agreeButton setImage:[UIImage imageNamed:@"signup_selected"] forState:UIControlStateSelected];
        [_agreeButton addTarget:self action:@selector(aggreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeButton;
}
- (UILabel *)aggreLabel
{
    if (!_aggreLabel) {
        _aggreLabel = [UILabel new];
        _aggreLabel.text = @"同意";
        _aggreLabel.textColor = DFColorWithHexString(@"#888888");
        _aggreLabel.font = [UIFont systemFontOfSize:14];
        _aggreLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _aggreLabel;
}
- (UIButton *)agreementButton
{
    if (!_agreementButton) {
        _agreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreementButton setTitle:@"海豚理财平台注册协议" forState:UIControlStateNormal];
        [_agreementButton setTitleColor:DFTINTCOLOR forState:UIControlStateNormal];
        [_agreementButton addTarget:self action:@selector(aggrementButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _agreementButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _agreementButton;
}
- (UIButton *)signUpButton
{
    if (!_signUpButton) {
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signUpButton setTitle:@"注册" forState:UIControlStateNormal];
        [_signUpButton setTitleColor:DFColorWithHexString(@"#FFFFFF") forState:UIControlStateNormal];
        [_signUpButton setBackgroundImage:[UIImage createImageWithColor:DFColorWithHexString(@"#1779D4")] forState:UIControlStateNormal];
        [_signUpButton addTarget:self action:@selector(signUpButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _signUpButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _signUpButton.layer.cornerRadius = 4.0;
        _signUpButton.layer.masksToBounds = YES;
    }
    return _signUpButton;
}

#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@"\n"]) {
        return YES;
    }
    
    if (_phoneNumberTextField == textField) {
        if (_phoneNumberTextField.text.length == 11) {
            return NO;
        }
    }
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _verificationCodeTextField && _phoneNumberTextField.text.length != 11) {
        [MBProgressHUD showTextAddToView:self.view Title:@"请先输入正确手机号" andHideTime:2];
        return NO;
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)sender
{
    if (_phoneNumberTextField.text.length == 11) {
        if (!self.isCountDowning) {
            _verificationCodeButton.enabled = YES;
//            _verificationCodeButton.layer.borderColor = DFTINTCOLOR.CGColor;
        }
        
    }else{
        _verificationCodeButton.enabled = NO;
//        _verificationCodeButton.layer.borderColor = [UIColor grayColor].CGColor;
    }
    
}

//开始倒计时
-(void) startTimer:(int)time{
    self.isCountDowning = YES;
//    _verificationCodeButton.layer.borderColor = [UIColor grayColor].CGColor;
    __block int timeout = time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.isCountDowning = NO;
                [_verificationCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
                if (_phoneNumberTextField.text.length == 11) {
                    _verificationCodeButton.enabled = YES;
//                    _verificationCodeButton.layer.borderColor = DFTINTCOLOR.CGColor;
                }else{
                    _verificationCodeButton.enabled = NO;
//                    _verificationCodeButton.layer.borderColor = [UIColor grayColor].CGColor;
                }
            });
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //执行倒计时时要做的操作
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_verificationCodeButton setTitle:[NSString stringWithFormat:@"再次验证(%@)",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _verificationCodeButton.enabled = NO;
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
}


#pragma mark - Action

-(void)getVerificationCodeButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    self.verificationCodeButton.enabled = NO;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GTNetWorking postWithUrl:DOLPHIN_API_AUTH_CODE params:@{@"phone":self.phoneNumberTextField.text,@"from":@"register"} header:nil showLoginIfNeed:NO success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([code integerValue] == 200) {
            [weakSelf startTimer:[data intValue]];
        }else{
            weakSelf.verificationCodeButton.enabled = YES;
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        self.verificationCodeButton.enabled = YES;
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showTextAddToView:weakSelf.view Title:@"网络出错，请稍后再试！" andHideTime:2];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)aggreButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
- (void)aggrementButtonClick:(UIButton *)sender
{
    [RegistrationAgreementController pushToController:self.navigationController];
}

- (void)signUpButtonClick:(UIButton *)sender
{
    if (!_agreeButton.selected) {
        [MBProgressHUD showTextAddToView:self.view Title:@"请先同意注册协议" andHideTime:2];
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSDictionary *params = @{@"phone":self.phoneNumberTextField.text,
                             @"code":self.verificationCodeTextField.text,
                             @"password":self.loginPasswordLabelTextField.text,
                             @"referrer":self.refereeTextField.text};
    [GTNetWorking postWithUrl:DOLPHIN_API_AUTH_REGISTER params:params header:nil showLoginIfNeed:NO success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([code integerValue] == 200) {
            BOOL need_pay_password = [data[@"need_pay_password"] boolValue];
            NSString *token = data[@"token"];
            [UserManager setUseraToken:token];
            [weakSelf leftButtonClick:nil];
            if (need_pay_password) {
                [SetPasswordController setWithPasswrodState:SetPasswordStateSetNewPassword passwordType:PasswordTypePay Complete:^(BOOL success) {
                    if (self.complete) {
                        self.complete(YES);
                    }
                }];
            }else{
                if (self.complete) {
                    self.complete(YES);
                }
            }
        }
        [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showTextAddToView:weakSelf.view Title:@"网络出错，请稍后再试！" andHideTime:2];
    }];
}

@end
