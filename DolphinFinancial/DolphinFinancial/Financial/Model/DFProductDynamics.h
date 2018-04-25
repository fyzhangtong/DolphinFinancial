//
//  DFProductDynamics.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/8.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Borrower.h"

/**
 产品动态
 */
@interface DFProductDynamics : NSObject

/**
 动态id
 */
@property (nonatomic, copy) NSNumber *id;

/**
 产品名称
 */
@property (nonatomic, copy) NSString *product_name;
/**
 购买金额
 */
@property (nonatomic, copy) NSString *buy_amount;
/**
 总金额
 */
@property (nonatomic, copy) NSString *total_amount;
/**
 总收益
 */
@property (nonatomic, copy) NSString *total_income;
/**
 昨日收益
 */
@property (nonatomic, copy) NSString *yesterday_income;
/**
 借款人信息
 */
@property (nonatomic, copy) NSString *borrower_info;
/**
 借款人
 */
@property (nonatomic, strong) NSArray<Borrower *> *borrowers;

/**
 购买时间
 */
@property (nonatomic, copy) NSString *buy_time;

@property (nonatomic, copy) NSString *expiration_time;
/**
 自动续
 */
@property (nonatomic, copy) NSString *auto_continue;
@end
