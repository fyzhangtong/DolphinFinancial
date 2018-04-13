//
//  FinancialTransferModel.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/13.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinancialTransferModel : NSObject

/**
 是否自动续投
 */
@property (nonatomic, assign) BOOL autoContinue;
/**
 产品ID
 */
@property (nonatomic, copy) NSNumber *product_id;
/**
 产品名称
 */
@property (nonatomic, copy) NSString *product_name;
/**
 产品收益利率
 */
@property (nonatomic, copy) NSString *interest_rate;
/**
 转入金额
 */
@property (nonatomic, copy) NSString *transfer_amount;
/**
 目标收益
 */
@property (nonatomic, copy) NSString *target_income;
/**
 余额
 */
@property (nonatomic, copy) NSString *balance_amount;
/**
 收益描述
 */
@property (nonatomic, copy) NSString *income_description;

@end
