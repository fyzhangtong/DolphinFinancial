//
//  MBProgressHUD+DFStyle.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/21.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MBProgressHUD+DFStyle.h"

@implementation MBProgressHUD (DFStyle)

+(instancetype)showTextAddToView:(UIView * )view Title:(NSString *)title andHideTime:(CGFloat)time{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud setMode:MBProgressHUDModeText];
    hud.detailsLabel.text = title;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:time];
    return hud;
}

@end
