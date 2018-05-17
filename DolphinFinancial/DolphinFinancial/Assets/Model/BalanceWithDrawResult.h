//
//  BalanceWithDrawResult.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/5/2.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceWithDrawResult : NSObject

/**
 账号
 */
@property (nonatomic, copy) NSString *remittance_account;
/**
 提现金额
 */
@property (nonatomic, copy) NSString *withdraw_amount;
/**
 余额
 */
@property (nonatomic, copy) NSString *balance;
/**
 手续费
 */
@property (nonatomic, copy) NSString *fee;
/**
 会员等级
 */
@property (nonatomic, copy) NSString *member_level;
/**
 会员收益利率
 */
@property (nonatomic, copy) NSString *interest_rate;

/**
 收款账户
 */
@property (nonatomic, copy) NSString *receive_account;

/**
 收款人
 */
@property (nonatomic, copy) NSString *receive_name;

@end
