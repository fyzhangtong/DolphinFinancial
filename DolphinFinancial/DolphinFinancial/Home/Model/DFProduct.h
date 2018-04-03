//
//  DFProduct.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/2.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFProduct : NSObject

/**
 产品ID
 */
@property (nonatomic, copy) NSNumber *productId;
/**
 产品名称
 */
@property (nonatomic, copy) NSString *name;
/**
 起始金额
 */
@property (nonatomic, copy) NSString *initial_amount;
/**
 产品描述
 */
@property (nonatomic, strong) NSArray<NSString *> *descriptions;
/**
 收益利率
 */
@property (nonatomic, copy) NSString *interest_rate;
/**
 收益天数
 */
@property (nonatomic, copy) NSNumber *interest_days;
/**
 当日剩余数量
 */
@property (nonatomic, copy) NSNumber *residue_number;
/**
 抢购时间
 */
@property (nonatomic, copy) NSString *purchase_time;
/**
 是否每日限量
 */
@property (nonatomic, assign) BOOL is_quantity_limit;
/**
 是否限时抢购
 */
@property (nonatomic, assign) BOOL is_time_limit;
/**
 是否VIP产品
 */
@property (nonatomic, assign) BOOL is_vip_product;
/**
 VIP等级限制
 */
@property (nonatomic, copy) NSString *vip_level_limit;



@end
