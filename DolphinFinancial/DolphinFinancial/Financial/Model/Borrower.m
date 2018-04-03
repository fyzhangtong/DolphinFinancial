//
//  Borrower.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/2.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "Borrower.h"

@implementation Borrower

- (void)setValue:(id)value forUndefinedKey:(NSString *)key

{
    
    if ([key isEqualToString:@"id"]) {
        self.borrowerId = value;
    }
}

@end
