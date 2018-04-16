//
//  AssetEarn.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/13.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 收益
 */
@interface AssetEarn : NSObject

/**
 日期
 */
@property (nonatomic, copy) NSString *date;
/**
 收益
 */
@property (nonatomic, copy) NSNumber *earn;

@end
