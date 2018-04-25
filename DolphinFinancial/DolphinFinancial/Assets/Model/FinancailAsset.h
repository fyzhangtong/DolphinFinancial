//
//  FinancailAsset.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/13.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinancailAsset : NSObject

/**
 资产ID
 */
@property (nonatomic, copy) NSNumber *id;
/**
 总资产
 */
@property (nonatomic, copy) NSString *total_asset;
/**
 余额
 */
@property (nonatomic, copy) NSString *balance_amount;
/**
 累计奖励
 */
@property (nonatomic, copy) NSString *bounty;
/**
 累计充值
 */
@property (nonatomic, copy) NSString *total_recharge;
/**
 累计提现
 */
@property (nonatomic, copy) NSString *total_withdraw;
/**
 累计收益
 */
@property (nonatomic, copy) NSString *total_earn;
/**
 理财资产
 */
@property (nonatomic, copy) NSString *total_finance_amount;
/**
 余额提现
 */
@property (nonatomic, copy) NSString *balance_withdraw;
/**
 昨日收益
 */
@property (nonatomic, copy) NSString *yesterday_total_earn;


@end
