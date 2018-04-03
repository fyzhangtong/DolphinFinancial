//
//  DFProduct.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/2.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "DFProduct.h"

@implementation DFProduct

- (void)setValue:(id)value forUndefinedKey:(NSString *)key

{
    
    if ([key isEqualToString:@"id"]) {
        self.productId = value;
    }
}

@end
