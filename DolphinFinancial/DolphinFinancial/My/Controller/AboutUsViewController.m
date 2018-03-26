//
//  AboutUsViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

+ (void)pushToController:(UIViewController *)controller
{
    AboutUsViewController *vc = [[AboutUsViewController alloc] init];
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"关于我们"];
    [self addLeftBackButton];
}

@end
