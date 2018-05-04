//
//  FindLoginPasswordController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/20.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "SetPasswordController.h"
#import "MBProgressHUD+DFStyle.h"
#import "UIImage+ImageWithColor.h"
#import "GTUtil.h"

@interface SetPasswordController ()<UITextFieldDelegate>

@property (nonatomic, copy) void(^complete)(BOOL success);
@property (nonatomic, assign) SetPasswordState setPasswordState;
@property (nonatomic, assign) PasswordType passwordType;

@property (nonatomic, strong) UILabel *phoneNumberOrNewPasswordLabel;
@property (nonatomic, strong) UILabel *VerificationCodeOrPasswordAgainLabel;
@property (nonatomic, strong) UITextField *phoneNumberOrNewPasswordTextField;
@property (nonatomic, strong) UITextField *VerificationCodeOrPasswordAgainTextField;
@property (nonatomic, strong) UIButton *getVerificationCodeButton;
@property (nonatomic, strong) UIButton *nextStepButton;
@property (nonatomic, strong) MASConstraint *getVerificationCodeButtonConstraintW;
@property (nonatomic, assign) BOOL isCountDowning;  //正在倒计时
@property (nonatomic, copy) NSString *u_token;      //未登录状态修改密码时请在header头信息中带上
@property (nonatomic, assign) BOOL setSuccess;

@end

@implementation SetPasswordController

+ (void)setWithPasswrodState:(SetPasswordState)setPasswrodState passwordType:(PasswordType)passwordType Complete:(void(^)(BOOL success))complete
{
    SetPasswordController *landVC = [[SetPasswordController alloc] init];
    landVC->_setPasswordState = setPasswrodState;
    landVC->_passwordType = passwordType;
    landVC.complete = complete;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[GTUtil getCurrentVC].navigationController pushViewController:landVC animated:YES];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCenterTitle:@"找回登录密码"];
    [self makeView];
    [self setPasswordType:_passwordType];
    [self setSetPasswordState:_setPasswordState];
    if (_passwordType == PasswordTypePay && _setPasswordState == SetPasswordStateSetNewPassword) {
        [self setRightButtonTitle:@"跳过"];
    }else{
        [self addLeftBackButton];
    }
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.complete) {
        self.complete(self.setSuccess);
    }
}

- (void)makeView
{
    [self.view addSubview:self.phoneNumberOrNewPasswordLabel];
    [self.phoneNumberOrNewPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
    }];
    
    [self.view addSubview:self.phoneNumberOrNewPasswordTextField];
    [self.phoneNumberOrNewPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneNumberOrNewPasswordLabel.mas_centerY);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(80);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(12);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = DFColor(242, 242, 242);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumberOrNewPasswordLabel.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(11);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-11);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.VerificationCodeOrPasswordAgainLabel];
    [self.VerificationCodeOrPasswordAgainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.phoneNumberOrNewPasswordLabel.mas_left);
    }];
    
    [self.view addSubview:self.getVerificationCodeButton];
    [self.getVerificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.VerificationCodeOrPasswordAgainLabel.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-12);
        self.getVerificationCodeButtonConstraintW = make.width.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.VerificationCodeOrPasswordAgainTextField];
    [self.VerificationCodeOrPasswordAgainTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.VerificationCodeOrPasswordAgainLabel.mas_centerY);
        make.left.mas_equalTo(self.phoneNumberOrNewPasswordTextField.mas_left);
        make.right.mas_equalTo(self.getVerificationCodeButton.mas_left).mas_offset(-9);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = DFColor(242, 242, 242);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.VerificationCodeOrPasswordAgainLabel.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(11);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-11);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.nextStepButton];
    [self.nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).mas_offset(10.0);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(12);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-12);
        make.height.mas_equalTo(40);
    }];
}
#pragma mark - getter
- (UILabel *)phoneNumberOrNewPasswordLabel
{
    if (!_phoneNumberOrNewPasswordLabel) {
        _phoneNumberOrNewPasswordLabel = [UILabel new];
        _phoneNumberOrNewPasswordLabel.textColor = DFColorWithHexString(@"#101010");
        _phoneNumberOrNewPasswordLabel.font = [UIFont systemFontOfSize:14];
        _phoneNumberOrNewPasswordLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _phoneNumberOrNewPasswordLabel;
}
- (UILabel *)VerificationCodeOrPasswordAgainLabel
{
    if (!_VerificationCodeOrPasswordAgainLabel) {
        _VerificationCodeOrPasswordAgainLabel = [UILabel new];
        _VerificationCodeOrPasswordAgainLabel.textColor = DFColorWithHexString(@"#101010");
        _VerificationCodeOrPasswordAgainLabel.font = [UIFont systemFontOfSize:14];
        _VerificationCodeOrPasswordAgainLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _VerificationCodeOrPasswordAgainLabel;
}
- (UITextField *)phoneNumberOrNewPasswordTextField
{
    if (!_phoneNumberOrNewPasswordTextField) {
        _phoneNumberOrNewPasswordTextField = [UITextField new];
        _phoneNumberOrNewPasswordTextField.textColor = DFColorWithHexString(@"#101010");
        _phoneNumberOrNewPasswordTextField.font = [UIFont systemFontOfSize:14];
        _phoneNumberOrNewPasswordTextField.textAlignment = NSTextAlignmentLeft;
        _phoneNumberOrNewPasswordTextField.delegate = self;
        [_phoneNumberOrNewPasswordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneNumberOrNewPasswordTextField;
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

- (UITextField *)VerificationCodeOrPasswordAgainTextField
{
    if (!_VerificationCodeOrPasswordAgainTextField) {
        _VerificationCodeOrPasswordAgainTextField = [UITextField new];
        _VerificationCodeOrPasswordAgainTextField.textColor = DFColorWithHexString(@"#101010");
        _VerificationCodeOrPasswordAgainTextField.font = [UIFont systemFontOfSize:14];
        _VerificationCodeOrPasswordAgainTextField.textAlignment = NSTextAlignmentLeft;
        _VerificationCodeOrPasswordAgainTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _VerificationCodeOrPasswordAgainTextField.delegate = self;
    }
    return _VerificationCodeOrPasswordAgainTextField;
}

- (UIButton *)nextStepButton
{
    if (!_nextStepButton) {
        _nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStepButton setTitle:@"登录" forState:UIControlStateNormal];
        [_nextStepButton setTitleColor:DFColorWithHexString(@"#FFFFFF") forState:UIControlStateNormal];
        [_nextStepButton setBackgroundImage:[UIImage createImageWithColor:DFColorWithHexString(@"#1779D4")] forState:UIControlStateNormal];
        _nextStepButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _nextStepButton.layer.cornerRadius = 4.0;
        _nextStepButton.layer.masksToBounds = YES;
        [_nextStepButton addTarget:self action:@selector(nextStepButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}
#pragma mark - setter
- (void)setSetPasswordState:(SetPasswordState)findPasswordState
{
    _phoneNumberOrNewPasswordTextField.text = nil;
    _VerificationCodeOrPasswordAgainTextField.text = nil;
    _setPasswordState = findPasswordState;
    if (_setPasswordState == SetPasswordStateVerify) {
        _phoneNumberOrNewPasswordLabel.text = @"账号";
        _VerificationCodeOrPasswordAgainLabel.text = @"验证码";
        _phoneNumberOrNewPasswordTextField.placeholder = @"请输入手机号";
        _VerificationCodeOrPasswordAgainTextField.placeholder = @"请输入手机验证码";
        _getVerificationCodeButtonConstraintW.mas_offset(124);
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        _phoneNumberOrNewPasswordTextField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        _getVerificationCodeButtonConstraintW.mas_offset(0);
        _VerificationCodeOrPasswordAgainLabel.text = @"确认密码";
        [_nextStepButton setTitle:@"确定" forState:UIControlStateNormal];
        _phoneNumberOrNewPasswordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
        if (_passwordType == PasswordTypeLogin) {
            _phoneNumberOrNewPasswordLabel.text = @"新密码";
            _phoneNumberOrNewPasswordTextField.placeholder = @"6-16位，含数字、字母";
            _VerificationCodeOrPasswordAgainTextField.placeholder = @"6-16位，含数字、字母";
            
        }else{
            _phoneNumberOrNewPasswordLabel.text = @"交易密码";
            _phoneNumberOrNewPasswordTextField.placeholder = @"请输入6位数字";
            _VerificationCodeOrPasswordAgainTextField.placeholder = @"请输入6位数字";

        }
        
    }
}

- (void)setPasswordType:(PasswordType)passwordType
{
    _passwordType = passwordType;
    if (_passwordType == PasswordTypeLogin) {
        //设置登录密码
        [self setCenterTitle:@"找回登录密码"];
    }else{
        //设置交易密码
        [self setCenterTitle:@"设置交易密码"];
    }
    
}

#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@"\n"]) {
        [_VerificationCodeOrPasswordAgainTextField resignFirstResponder];
        return YES;
    }
    if (self.setPasswordState == SetPasswordStateVerify) {
        if (_phoneNumberOrNewPasswordTextField == textField) {
            if (_phoneNumberOrNewPasswordTextField.text.length == 11) {
                return NO;
            }
        }
    }else{
        if (textField.text.length == 16) {
            return NO;
        }
    }
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.setPasswordState == SetPasswordStateVerify) {
        if (textField == _VerificationCodeOrPasswordAgainTextField && _phoneNumberOrNewPasswordTextField.text.length != 11) {
            [MBProgressHUD showTextAddToView:self.view Title:@"请先输入正确手机号" andHideTime:2];
            return NO;
        }
    }else{
        if (textField == _VerificationCodeOrPasswordAgainTextField ) {
            if (_phoneNumberOrNewPasswordTextField.text.length < 6 || _phoneNumberOrNewPasswordTextField.text.length > 16) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)sender
{
    if (_phoneNumberOrNewPasswordTextField.text.length == 11) {
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
                if (_phoneNumberOrNewPasswordTextField.text.length == 11) {
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

- (void)rightButtonClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeModelButtonClick:(UIButton *)sender
{
    self.setPasswordState = sender.selected ? SetPasswordStateVerify : SetPasswordStateSetNewPassword;
}
-(void)getVerificationCodeButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    self.getVerificationCodeButton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GTNetWorking postWithUrl:DOLPHIN_API_AUTH_CODE params:@{@"phone":self.phoneNumberOrNewPasswordTextField.text,@"from":@"change"} header:nil showLoginIfNeed:YES success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([code integerValue] == 200) {
            [weakSelf startTimer:[data intValue]];
        }else{
            weakSelf.getVerificationCodeButton.enabled = YES;
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }        
    } fail:^(NSError *error) {
        weakSelf.getVerificationCodeButton.enabled = YES;
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showTextAddToView:weakSelf.view Title:error.localizedDescription andHideTime:2];
    }];
}
- (void)nextStepButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    if (self.setPasswordState == SetPasswordStateVerify) {
        [self requestVerificationCode];
    }else{
        if (self.passwordType == PasswordTypeLogin) {
            //设置登录密码
            [self setPassword:DOLPHIN_API_AUTH_PWDLOSS];
        }else{
            //设置支付密码
            [self setPassword:DOLPHIN_API_PAYINIT];
        }
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//获取验证码
- (void)requestVerificationCode
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *param = @{@"phone":self.phoneNumberOrNewPasswordTextField.text,@"code":self.VerificationCodeOrPasswordAgainTextField.text};
    [GTNetWorking postWithUrl:DOLPHIN_API_AUTH_CAPTCHA_CHECK params:param header:nil showLoginIfNeed:NO success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code integerValue] == 200) {
            self.u_token = data;
            self.setPasswordState = SetPasswordStateSetNewPassword;
        }else{
            [MBProgressHUD showTextAddToView:self.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showTextAddToView:self.view Title:error.localizedDescription andHideTime:2];
    }];
}
//设置密码
- (void)setPassword:(NSString *)url
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{@"password":self.phoneNumberOrNewPasswordTextField.text,@"confirm_password":self.VerificationCodeOrPasswordAgainTextField.text};
    NSMutableDictionary *header = [[NSMutableDictionary alloc] initWithCapacity:1];
    SafeDictionarySetObject(header, self.u_token, @"U-Token");
    [GTNetWorking postWithUrl:url params:params header:header showLoginIfNeed:YES success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code integerValue] == 200) {
            self.setSuccess = YES;
            [self rightButtonClick:nil];
        }
        [MBProgressHUD showTextAddToView:self.view Title:msg andHideTime:2];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showTextAddToView:self.view Title:error.localizedDescription andHideTime:2];
    }];
}

@end
