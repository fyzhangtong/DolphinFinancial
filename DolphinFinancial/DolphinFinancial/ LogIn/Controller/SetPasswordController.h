//
//  FindLoginPasswordController.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/20.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseViewController.h"

typedef enum SetPasswordState
{
    SetPasswordStateVerify = 0,
    SetPasswordStateSetNewPassword = 1
}SetPasswordState;

typedef enum PasswordType
{
    PasswordTypeLogin = 0,
    PasswordTypePay = 1
}PasswordType;
/**
 找回密码
 */
@interface SetPasswordController : BaseViewController

+ (void)setWithPasswrodState:(SetPasswordState)setPasswrodState passwordType:(PasswordType)passwordType Complete:(void(^)(BOOL success))complete;

@end
