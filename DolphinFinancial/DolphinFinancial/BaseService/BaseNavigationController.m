//
//  BaseNavigationController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/16.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseNavigationController.h"

#import "BaseViewController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.viewControllers.count>=2) {
        BaseViewController *vc = (BaseViewController *)self.topViewController;
        BaseViewController *lastVC = self.viewControllers[self.viewControllers.count-2];
        if ([vc gestureRecognizerShouldBegin] && [lastVC nextControllergestureRecognizerShouldBegin]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
