//
//  DolphinFinancialApi.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/30.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#ifndef DolphinFinancialApi_h
#define DolphinFinancialApi_h

#define DOLPHIN_HOST @"http://127.0.0.1:8801/api/v1"

//根据uri 生成url
#define DOLPHIN_API(u) [NSString stringWithFormat:@"%@/%@",DOLPHIN_HOST,(u)]

#pragma mark - 用户
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
 交易密码设置接口
 */
#define DOLPHIN_API_PAYINIT DOLPHIN_API(@"payinit")
/**
 手机验证码校验接口
 */
#define DOLPHIN_API_AUTH_CAPTCHA_CHECK DOLPHIN_API(@"auth/captcha-check")

#pragma mark -
/**
 首页数据接口
 */
#define DOLPHIN_API_INDEX DOLPHIN_API(@"index")
/**
 理财产品接口
 */
#define DOLPHIN_API_PRODUCTS DOLPHIN_API(@"products")
/**
 用户理财产品接口
 */
#define DOLPHIN_API_USER_PRODUCTS DOLPHIN_API(@"user/products")
/**
 用户理财产品详情接口
 @param u 用户理财产品ID
 */
#define DOLPHIN_API_USER_PRODUCT(u) [NSString stringWithFormat:@"%@/%@",DOLPHIN_API(@"product"),(u)]
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


#endif /* DolphinFinancialApi_h */
