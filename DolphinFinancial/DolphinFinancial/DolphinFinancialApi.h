//
//  DolphinFinancialApi.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/30.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#ifndef DolphinFinancialApi_h
#define DolphinFinancialApi_h

//#define DOLPHIN_HOST @"http://127.0.0.1:8801/api/v1"
#define DOLPHIN_HOST @"https://94d246c0.ngrok.io/api/v1"

//根据uri 生成url
#define DOLPHIN_API(u) [NSString stringWithFormat:@"%@/%@",DOLPHIN_HOST,(u)]

#pragma mark - 登录/注册/验证码
/**
 用户登录接口
 */
#define DOLPHIN_API_AUTH_LOGIN DOLPHIN_API(@"auth/login")
/**
 手机验证码接口
 */
#define DOLPHIN_API_AUTH_CODE DOLPHIN_API(@"auth/code")
/**
 用户找回密码接口
 */
#define DOLPHIN_API_AUTH_PWDLOSS DOLPHIN_API(@"auth/pwdloss")
/**
 用户注册接口
 */
#define DOLPHIN_API_AUTH_REGISTER DOLPHIN_API(@"auth/register")
/**
 手机验证码校验接口
 */
#define DOLPHIN_API_AUTH_CAPTCHA_CHECK DOLPHIN_API(@"auth/captcha-check")

#pragma mark - 产品 product
/**
 理财产品接口
 */
#define DOLPHIN_API_PRODUCTS DOLPHIN_API(@"products")
/**
 用户理财产品详情接口
 @param u 用户理财产品ID
 */
#define DOLPHIN_API_USER_PRODUCT(u) [NSString stringWithFormat:@"%@/%@",DOLPHIN_API(@"user/product"),(u)]
/**
 用户产品借款信息接口
 @param u 用户理财产品ID
 */
#define DOLPHIN_API_USER_PRODUCTS_BORROWERS(u) [NSString stringWithFormat:@"%@/borrowers",DOLPHIN_API_USER_PRODUCT(u)]
/**
 理财产品详情接口
 @param u 理财产品ID
 */
#define DOLPHIN_API_PRODUCT(u) [NSString stringWithFormat:@"%@/%@",DOLPHIN_API(@"product"),(u)]
/**
 产品动态接口
 @param u 理财产品ID
 */
#define DOLPHIN_API_PRODUCT_DYNAMICS(u) [NSString stringWithFormat:@"%@/%@/dynamics",DOLPHIN_API(@"product"),(u)]
/**
 理财产品金额转入页数据接口
 */
#define DOLPHIN_API_PRODUCT_TRANSFER_INIT DOLPHIN_API(@"product/transfer/init")

/**
 理财产品金额确认转入接口
 */
#define DOLPHIN_API_PRODUCT_TRANSFER_CONFIRM DOLPHIN_API(@"product/transfer/confirm")

#pragma mark - 资产 asset
/**
 资产首页接口
 */
#define DOLPHIN_API_ASSET DOLPHIN_API(@"asset")

/**
 资产记录接口
 */
#define DOLPHIN_API_ASSET_RECORD DOLPHIN_API(@"asset/record")
/**
 收益记录接口
 */
#define DOLPHIN_API_EARN_RECORD DOLPHIN_API(@"earn/record")

#pragma mark - 余额 balance
/**
 余额页面接口
 */
#define DOLPHIN_API_BALANCE DOLPHIN_API(@"balance")

/**
 余额充值页面接口
 */
#define DOLPHIN_API_BALANCE_RECHARGE DOLPHIN_API(@"balance/recharge")

/**
 余额充值确认接口
 */
#define DOLPHIN_API_BALANCE_RECHARGE_CONFIRM DOLPHIN_API(@"balance/recharge/confirm")

/**
 余额提现页面接口
 */
#define DOLPHIN_API_BALANCE_WITHDRAW DOLPHIN_API(@"balance/withdraw")
/**
 余额提现确认接口
 */
#define DOLPHIN_API_BALANCE_WITHDRAW_CONFIRM DOLPHIN_API(@"balance/withdraw/confirm")

#pragma mark - 我的 user
/**
 用户理财产品接口
 */
#define DOLPHIN_API_USER_PRODUCTS DOLPHIN_API(@"user/products")
/**
 我的数据接口
 */
#define DOLPHIN_API_USER DOLPHIN_API(@"user")

/**
 会员信息接口
 */
#define DOLPHIN_API_USER_MEMBERS DOLPHIN_API(@"user/members")

/**
 登录密码修改接口
 */
#define DOLPHIN_API_USER_PASSWORD_MODIFY DOLPHIN_API(@"user/password/modify")

/**
 支付密码修改接口
 */
#define DOLPHIN_API_USER_PAY_MODIFY DOLPHIN_API(@"user/pay/modify")


#pragma mark - 支付
/**
 交易密码校验接口
 */
#define DOLPHIN_API_PAYCHECK DOLPHIN_API(@"paycheck")
/**
 交易密码设置接口
 */
#define DOLPHIN_API_PAYINIT DOLPHIN_API(@"payinit")

#pragma mark - 其他 other
/**
 首页数据接口
 */
#define DOLPHIN_API_INDEX DOLPHIN_API(@"index")

/**
 系统公告接口
 */
#define DOLPHIN_API_NOTICES DOLPHIN_API(@"notices")

/**
 反馈接口
 */
#define DOLPHIN_API_FEEDBACK DOLPHIN_API(@"feedback")

/**
 退出登录接口
 */
#define DOLPHIN_API_EXIT DOLPHIN_API(@"exit")

/**
 转出金额
 */
#define DOLPHIN_API_USER_PRODUCT_ROLLOUT DOLPHIN_API(@"user/product/rollout")

#endif /* DolphinFinancialApi_h */
