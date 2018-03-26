//
//  MessageCenterViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MessageCenterViewController.h"

@interface MessageCenterViewController ()

@end

@implementation MessageCenterViewController

+ (void)pushToController:(UIViewController *)controller
{
    MessageCenterViewController *vc = [[MessageCenterViewController alloc] init];
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"消息中心"];
    [self addLeftBackButton];
}

@end
