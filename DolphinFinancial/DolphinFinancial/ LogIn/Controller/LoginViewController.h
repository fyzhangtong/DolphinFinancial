//
//  LoginViewController.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/20.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseViewController.h"

/**
 登录
 */
@interface LoginViewController : BaseViewController

+ (void)loginWithComplete:(void(^)(BOOL success))complete;

@end
