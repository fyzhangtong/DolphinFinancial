//
//  DFProductDynamics.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/8.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "DFProductDynamics.h"

@implementation DFProductDynamics

+(nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"borrowers"       : Borrower.class
             };
}

@end
