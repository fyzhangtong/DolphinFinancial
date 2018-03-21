//
//  MyFincialViewController.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/21.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseViewController.h"

/**
 我的理财产品
 */
@interface MyFincialViewController : BaseViewController

+ (void)pushToController:(UIViewController *)controller Complete:(void(^)(BOOL success))complete;

@end
