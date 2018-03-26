//
//  ChangeLoginPasswordViewController.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseViewController.h"

typedef enum ChangePasswordType{
    ChangePasswordTypeLogin = 0,
    ChangePasswordTypePayment = 1
}ChangePasswordType;

/**
 修改登录密码
 */
@interface ChangePasswordViewController : BaseViewController

+ (void)pushToController:(UIViewController *)controller passwordType:(ChangePasswordType)passwordType;

@end
