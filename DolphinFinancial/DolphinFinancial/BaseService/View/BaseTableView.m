//
//  BaseTableView.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    
    return [super hitTest:point withEvent:event];
}

@end
