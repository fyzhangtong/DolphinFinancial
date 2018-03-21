//
//  MBProgressHUD+DFStyle.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/21.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (DFStyle)

+(instancetype)showTextAddToView:(UIView * )view Title:(NSString *)title andHideTime:(CGFloat)time;

@end
