//
//  Borrower.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/2.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Borrower : NSObject

/**
 借款信息ID
 */
@property (nonatomic, copy) NSNumber *id;
/**
 产品名称
 */
@property (nonatomic, copy) NSString *product_name;
/**
 借款人
 */
@property (nonatomic, copy) NSString *borrower;
/**
 借款金额
 */
@property (nonatomic, copy) NSString *borrow_amount;
/**
 借款状态
 */
@property (nonatomic, copy) NSString *status;
/**
 借款时间
 */
@property (nonatomic, copy) NSString *borrow_time;

@end
