//
//  WithdrawalsViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "WithdrawalsViewController.h"

@interface WithdrawalsViewController ()

@end

@implementation WithdrawalsViewController

+ (void)pushToController:(UIViewController *)controller
{
    WithdrawalsViewController *bvc = [[WithdrawalsViewController alloc] init];
    [controller.navigationController pushViewController:bvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}
- (void)makeView
{
    [self setCenterTitle:@"提现"];
    [self addLeftBackButton];
}

@end
