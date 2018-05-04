//
//  LoginViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/20.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "UIImage+ImageWithColor.h"
#import "SetPasswordController.h"
#import "SignUpViewController.h"
#import "GTUtil.h"
#import "UserManager.h"
#import "SetPasswordController.h"

typedef enum LoginModel
{
    LoginModelPassword = 0,
    LoginModelVerificationCode = 1
}LoginModel;

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, copy) void(^complete)(BOOL success);
@property (nonatomic, assign) LoginModel loginModel;

@property (nonatomic, strong) UILabel *phoneNumberLabel;
@property (nonatomic, strong) UILabel *passwordOrVerificationCodeLabel;
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UITextField *passwordOrVerificationCodeTextField;
@property (nonatomic, strong) UIButton *getVerificationCodeButton;
@property (nonatomic, strong) UIButton *changeModelButton;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *signUpButton;
@property (nonatomic, strong) UIButton *findPasswordButton;
@property (nonatomic, strong) MASConstraint *getVerificationCodeButtonConstraintW;
@property (nonatomic, assign) BOOL isCountDowning;  //正在倒计时

@property (nonatomic, assign) BOOL loginSuccess;

@end

@implementation LoginViewController

#pragma mark - 登录方法
+ (void)loginWithComplete:(void(^)(BOOL success))complete
{
    if ([[GTUtil getCurrentVC] isKindOfClass:[LoginViewController class]]) {
        return;
    }
    LoginViewController *landVC = [[LoginViewController alloc] init];
    landVC.complete = complete;
    BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:landVC];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[GTUtil getCurrentVC] presentViewController:navigationController animated:YES completion:nil];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addLeftBackButton];
    [self makeView];
    self.loginModel = LoginModelPassword;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.complete) {
        self.complete(self.loginSuccess);
    }
    
}

- (void)makeView
{
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
    
    [self.view addSubview:self.passwordOrVerificationCodeLabel];
    [self.passwordOrVerificationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.phoneNumberLabel.mas_left);
    }];
    
    [self.view addSubview:self.getVerificationCodeButton];
    [self.getVerificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordOrVerificationCodeLabel.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-12);
        self.getVerificationCodeButtonConstraintW = make.width.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.passwordOrVerificationCodeTextField];
    [self.passwordOrVerificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordOrVerificationCodeLabel.mas_centerY);
        make.left.mas_equalTo(self.phoneNumberTextField.mas_left);
        make.right.mas_equalTo(self.getVerificationCodeButton.mas_left).mas_offset(-9);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = DFColor(242, 242, 242);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordOrVerificationCodeLabel.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(11);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-11);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.changeModelButton];
    [self.changeModelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-12);
        make.height.mas_equalTo(30);
    }];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.changeModelButton.mas_bottom).mas_offset(2.0);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(12);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-12);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.signUpButton];
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(7);
        make.left.mas_equalTo(self.loginButton.mas_left);
        //make.width.mas_equalTo(57);
        make.height.mas_equalTo(23);
    }];
    
    [self.view addSubview:self.findPasswordButton];
    [self.findPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signUpButton.mas_top);
        make.right.mas_equalTo(self.loginButton.mas_right);
        //make.width.mas_equalTo(57);
        make.height.mas_equalTo(23);
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
        _phoneNumberLabel.text = @"账号";
    }
    return _phoneNumberLabel;
}
- (UILabel *)passwordOrVerificationCodeLabel
{
    if (!_passwordOrVerificationCodeLabel) {
        _passwordOrVerificationCodeLabel = [UILabel new];
        _passwordOrVerificationCodeLabel.textColor = DFColorWithHexString(@"#101010");
        _passwordOrVerificationCodeLabel.font = [UIFont systemFontOfSize:14];
        _passwordOrVerificationCodeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _passwordOrVerificationCodeLabel;
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

- (UIButton *)getVerificationCodeButton
{
    if (!_getVerificationCodeButton) {
        _getVerificationCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getVerificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getVerificationCodeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_getVerificationCodeButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_getVerificationCodeButton setTitleColor:DFTINTCOLOR forState:UIControlStateNormal];
        [_getVerificationCodeButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
        [_getVerificationCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _getVerificationCodeButton.layer.borderWidth = 1;
        _getVerificationCodeButton.layer.cornerRadius = 4;
        _getVerificationCodeButton.layer.masksToBounds = YES;
        _getVerificationCodeButton.enabled = NO;
        _getVerificationCodeButton.layer.borderColor = [UIColor grayColor].CGColor;
        [_getVerificationCodeButton addTarget:self action:@selector(getVerificationCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _getVerificationCodeButton;
}

- (UITextField *)passwordOrVerificationCodeTextField
{
    if (!_passwordOrVerificationCodeTextField) {
        _passwordOrVerificationCodeTextField = [UITextField new];
        _passwordOrVerificationCodeTextField.textColor = DFColorWithHexString(@"#101010");
        _passwordOrVerificationCodeTextField.font = [UIFont systemFontOfSize:14];
        _passwordOrVerificationCodeTextField.textAlignment = NSTextAlignmentLeft;
        _passwordOrVerificationCodeTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordOrVerificationCodeTextField.delegate = self;
    }
    return _passwordOrVerificationCodeTextField;
}
- (UIButton *)changeModelButton
{
    if (!_changeModelButton) {
        _changeModelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeModelButton setTitle:@"手机快捷登录>>" forState:UIControlStateNormal];
        [_changeModelButton setTitle:@"密码登录>>" forState:UIControlStateSelected];
        [_changeModelButton setTitleColor:DFColorWithHexString(@"#101010") forState:UIControlStateNormal];
        _changeModelButton.alpha = 0.3;
        _changeModelButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.changeModelButton addTarget:self action:@selector(changeModelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeModelButton;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:DFColorWithHexString(@"#FFFFFF") forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage createImageWithColor:DFColorWithHexString(@"#1779D4")] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _loginButton.layer.cornerRadius = 4.0;
        _loginButton.layer.masksToBounds = YES;
    }
    return _loginButton;
}
- (UIButton *)signUpButton
{
    if (!_signUpButton) {
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signUpButton setTitle:@"快速注册" forState:UIControlStateNormal];
        [_signUpButton setTitleColor:DFColorWithHexString(@"#101010 100%") forState:UIControlStateNormal];
        _signUpButton.alpha = 0.3;
        _signUpButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_signUpButton addTarget:self action:@selector(signUpButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signUpButton;
}
- (UIButton *)findPasswordButton
{
    if (!_findPasswordButton) {
        _findPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_findPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_findPasswordButton setTitleColor:DFColorWithHexString(@"#101010 100%") forState:UIControlStateNormal];
        _findPasswordButton.alpha = 0.3;
        _findPasswordButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_findPasswordButton addTarget:self action:@selector(findPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findPasswordButton;
}
#pragma mark - setter
- (void)setLoginModel:(LoginModel)loginModel
{
    _loginModel = loginModel;
    if (_loginModel == LoginModelPassword) {
        _getVerificationCodeButtonConstraintW.mas_offset(0);
        [self setCenterTitle:@"密码登录"];
        _passwordOrVerificationCodeLabel.text = @"密码";
        _passwordOrVerificationCodeTextField.placeholder = @"请输入密码";
        _changeModelButton.selected = NO;
    }else{
        _getVerificationCodeButtonConstraintW.mas_offset(124);
        [self setCenterTitle:@"手机快捷登录"];
        _passwordOrVerificationCodeLabel.text = @"验证码";
        _passwordOrVerificationCodeTextField.placeholder = @"请输入验证码";
        _changeModelButton.selected = YES;
    }
}
#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@"\n"]) {
        [_passwordOrVerificationCodeTextField resignFirstResponder];
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
    if (textField == _passwordOrVerificationCodeTextField && _phoneNumberTextField.text.length != 11) {
        [MBProgressHUD showTextAddToView:self.view Title:@"请先输入正确手机号" andHideTime:2];
        return NO;
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)sender
{
    if (_phoneNumberTextField.text.length == 11) {
        if (!self.isCountDowning) {
            _getVerificationCodeButton.enabled = YES;
            _getVerificationCodeButton.layer.borderColor = DFTINTCOLOR.CGColor;
        }
        
    }else{
        _getVerificationCodeButton.enabled = NO;
        _getVerificationCodeButton.layer.borderColor = [UIColor grayColor].CGColor;
    }
    
}

//开始倒计时
-(void) startTimer:(int)time{
    self.isCountDowning = YES;
    _getVerificationCodeButton.layer.borderColor = [UIColor grayColor].CGColor;
    __block int timeout = time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.isCountDowning = NO;
                [_getVerificationCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
                if (_phoneNumberTextField.text.length == 11) {
                    _getVerificationCodeButton.enabled = YES;
                    _getVerificationCodeButton.layer.borderColor = DFTINTCOLOR.CGColor;
                }else{
                    _getVerificationCodeButton.enabled = NO;
                    _getVerificationCodeButton.layer.borderColor = [UIColor grayColor].CGColor;
                }
            });
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //执行倒计时时要做的操作
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_getVerificationCodeButton setTitle:[NSString stringWithFormat:@"再次验证(%@)",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _getVerificationCodeButton.enabled = NO;
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
}


#pragma mark - Action

- (void)signUpButtonClick:(UIButton *)sender
{
    [SignUpViewController pushToController:self Complete:nil];
}

- (void)changeModelButtonClick:(UIButton *)sender
{
    self.loginModel = sender.selected ? LoginModelPassword : LoginModelVerificationCode;
}
-(void)getVerificationCodeButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    self.getVerificationCodeButton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *param = @{@"phone":self.phoneNumberTextField.text,@"from":@"login"};
    [GTNetWorking postWithUrl:DOLPHIN_API_AUTH_CODE params:param header:nil showLoginIfNeed:YES success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([code integerValue] == 200) {
            int time = [data intValue];
            [weakSelf startTimer:time];
        }else{
            weakSelf.getVerificationCodeButton.enabled = YES;
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        weakSelf.getVerificationCodeButton.enabled = YES;
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
    
}

-(void)findPasswordButtonClick:(UIButton *)sender
{
    [SetPasswordController setWithPasswrodState:SetPasswordStateVerify passwordType:PasswordTypeLogin Complete:nil];
}

- (void)leftButtonClick:(UIButton *)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)loginButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (_phoneNumberTextField.text.length != 11) {
        [MBProgressHUD showTextAddToView:self.view Title:@"请输入正确手机号" andHideTime:1];
        return;
    }
    
    NSString *type;
    NSString *pwdOrCodeKey;
    if (self.loginModel == LoginModelPassword) {
        type = @"pwd";
        pwdOrCodeKey = @"password";
    }else{
        type = @"code";
        pwdOrCodeKey = @"code";
    }
    if (self.passwordOrVerificationCodeTextField.text.length == 0) {
        [MBProgressHUD showTextAddToView:self.view Title:@"请输入验证码" andHideTime:2];
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSDictionary *param = @{@"phone":_phoneNumberTextField.text,@"type":type,pwdOrCodeKey:self.passwordOrVerificationCodeTextField.text};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GTNetWorking postWithUrl:DOLPHIN_API_AUTH_LOGIN params:param header:nil showLoginIfNeed:NO success:^(NSNumber *code, NSString *msg, id data) {

        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([code integerValue] == 200) {
            //成功
            weakSelf.loginSuccess = YES;
            [UserManager setUseraToken:data[@"token"]];
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                if ([data[@"need_pay_password"] boolValue]) {
                    [SetPasswordController setWithPasswrodState:SetPasswordStateSetNewPassword passwordType:PasswordTypePay Complete:^(BOOL success) {
                    }];
                }
            }];
        }else{
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showTextAddToView:weakSelf.view Title:error.localizedDescription andHideTime:2];
    }];
    
}

@end
