//
//  FinacialTransferViewController.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/10.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseViewController.h"

/**
 产品转入页面
 */
@interface FinacialTransferViewController : BaseViewController

+ (void)pushToController:(UIViewController *)controller productId:(NSNumber *)productId;

@end
