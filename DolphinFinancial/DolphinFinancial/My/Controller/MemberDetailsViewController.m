//
//  MemberDetailsViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MemberDetailsViewController.h"

@interface MemberDetailsViewController ()

@end

@implementation MemberDetailsViewController

+ (void)pushToController:(UIViewController *)controller
{
    MemberDetailsViewController *vc = [[MemberDetailsViewController alloc] init];
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"会员详情"];
    [self addLeftBackButton];
}

@end
