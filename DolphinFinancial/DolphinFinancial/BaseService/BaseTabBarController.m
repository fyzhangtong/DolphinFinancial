//
//  BaseTabBarController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/16.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTabBarController.h"
#import "AssetsViewController.h"
#import "MyViewController.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "UserManager.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

#pragma mark - tabbar delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    //这里我判断的是当前点击的tabBarItem的标题
//    if ([viewController.tabBarItem.title isEqualToString:@"资产"]) {
//
//        return [BaseTabBarController checkLogin:2 tabBarController:tabBarController];
//
//    }else if([viewController.tabBarItem.title isEqualToString:@"我的"]){
//
//        return [BaseTabBarController checkLogin:3 tabBarController:tabBarController];
//    }
    return YES;
}

+(BOOL)checkLogin:(NSInteger)index tabBarController:(UITabBarController *)tabBarController
{
    __weak typeof(tabBarController) weakTabBarController = tabBarController;
    if ([UserManager userToken].length) {
        return YES;
    }else{
        [LoginViewController loginWithComplete:^(BOOL success) {
            if (success) {
                weakTabBarController.selectedIndex = index;
            }
        }];
        return NO;
    }
}


@end
