//
//  QuestionFeedbackViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "QuestionFeedbackViewController.h"

@interface QuestionFeedbackViewController ()

@end

@implementation QuestionFeedbackViewController

+ (void)pushToController:(UIViewController *)controller
{
    QuestionFeedbackViewController *vc = [[QuestionFeedbackViewController alloc] init];
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"问题反馈"];
    [self addLeftBackButton];
}

@end