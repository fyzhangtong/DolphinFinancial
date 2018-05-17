//
//  FinacialDetailsController.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseViewController.h"

/**
 理财产品详情
 */
@interface FinacialDetailsController : BaseViewController

+ (void)pushTo:(UINavigationController *)nc productId:(NSNumber *)productId;

@end
