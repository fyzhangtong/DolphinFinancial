//
//  MessageDetailsViewController.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseViewController.h"

@class DFNotice;

@interface MessageDetailsViewController : BaseViewController

+ (void)pushToController:(UINavigationController *)navigationController notice:(DFNotice *)notice;

@end
