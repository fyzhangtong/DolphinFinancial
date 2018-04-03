//
//  UserFinancial.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/2.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Borrower;

@interface UserFinancial : NSObject


/**
 我的理财产品ID
 */
@property (nonatomic, copy) NSNumber *userFinancialId;
/**
 产品名称
 */
@property (nonatomic, copy) NSString *product_name;
/**
 购买金额
 */
@property (nonatomic, copy) NSString *buy_amount;
/**
 当前产品总金额
 */
@property (nonatomic, copy) NSString *total_amount;
/**
 累计收益
 */
@property (nonatomic, copy) NSString *total_income;
/**
 昨日收益
 */
@property (nonatomic, copy) NSString *yesterday_income;
/**
 借款人描述信息
 */
@property (nonatomic, copy) NSString *borrower_info;
/**
 借款人列表
 */
@property (nonatomic, strong) NSArray<Borrower *> *borrowers;
/**
 购买时间
 */
@property (nonatomic, copy) NSString *buy_time;
/**
 到期时间
 */
@property (nonatomic, copy) NSString *expiration_time;


@end
