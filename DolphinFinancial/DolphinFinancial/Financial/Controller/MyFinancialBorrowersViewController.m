//
//  MyFinancialBorrowersViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/28.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyFinancialBorrowersViewController.h"

@interface MyFinancialBorrowersViewController ()

@end

@implementation MyFinancialBorrowersViewController

+ (void)pushToController:(UIViewController *)controller
{
    MyFinancialBorrowersViewController *vc = [[MyFinancialBorrowersViewController alloc] init];
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"借款人列表"];
    [self addLeftBackButton];
}

@end
